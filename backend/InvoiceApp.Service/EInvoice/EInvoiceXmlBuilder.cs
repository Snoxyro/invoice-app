using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using InvoiceApp.Common.Entities;

namespace InvoiceApp.Service.EInvoice;

public static class EInvoiceXmlBuilder
{
    private const string InvoiceNamespaceUri = "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2";
    private const string CacNamespaceUri = "urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";
    private const string CbcNamespaceUri = "urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2";
    private const string ExtNamespaceUri = "urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2";
    private const string DsNamespaceUri = "http://www.w3.org/2000/09/xmldsig#";
    private const string DraftInvoiceNumberPlaceholder = "(taslak — gönderildiğinde numara atanacak)";
    private const string VatTaxTypeCode = "0015";

    public static byte[] Build(Invoice invoice)
    {
        XNamespace invNs = InvoiceNamespaceUri;
        XNamespace cac = CacNamespaceUri;
        XNamespace cbc = CbcNamespaceUri;
        XNamespace ext = ExtNamespaceUri;
        XNamespace ds = DsNamespaceUri;

        var lines = invoice.InvoiceLines.ToList();

        var invoiceNumberText = invoice.Status == InvoiceStatus.Sent && !string.IsNullOrEmpty(invoice.InvoiceNumber)
            ? invoice.InvoiceNumber
            : DraftInvoiceNumberPlaceholder;

        var root = new XElement(
            invNs + "Invoice",
            new XAttribute(XNamespace.Xmlns + "cac", cac.NamespaceName),
            new XAttribute(XNamespace.Xmlns + "cbc", cbc.NamespaceName),
            new XAttribute(XNamespace.Xmlns + "ext", ext.NamespaceName),
            new XAttribute(XNamespace.Xmlns + "ds", ds.NamespaceName),
            BuildExtensionsPlaceholder(ext, ds),
            new XElement(cbc + "UBLVersionID", "2.1"),
            new XElement(cbc + "CustomizationID", "TR1.2"),
            new XElement(cbc + "ProfileID", "TICARIFATURA"),
            new XElement(cbc + "ID", invoiceNumberText),
            new XElement(cbc + "UUID", BuildDeterministicUuid(invoice.InvoiceId)),
            new XElement(cbc + "IssueDate", invoice.InvoiceDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture)),
            new XElement(cbc + "IssueTime", invoice.CreatedDate.ToString("HH:mm:ss", CultureInfo.InvariantCulture)),
            new XElement(cbc + "InvoiceTypeCode", "SATIS"),
            new XElement(cbc + "DocumentCurrencyCode", "TRY"),
            new XElement(cbc + "LineCountNumeric", lines.Count.ToString(CultureInfo.InvariantCulture)),
            BuildSupplierParty(cac, cbc, invoice),
            BuildCustomerParty(cac, cbc, invoice.Customer),
            BuildTaxTotal(cac, cbc, lines),
            BuildLegalMonetaryTotal(cac, cbc, invoice),
            lines.Select((line, index) => BuildInvoiceLine(cac, cbc, line, index + 1)));

        var document = new XDocument(new XDeclaration("1.0", "UTF-8", null), root);

        var settings = new XmlWriterSettings
        {
            Encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false),
            Indent = false
        };

        using var memoryStream = new MemoryStream();

        using (var xmlWriter = XmlWriter.Create(memoryStream, settings))
        {
            document.Save(xmlWriter);
        }

        return memoryStream.ToArray();
    }

    private static XElement BuildExtensionsPlaceholder(XNamespace ext, XNamespace ds)
    {
        return new XElement(
            ext + "UBLExtensions",
            new XElement(
                ext + "UBLExtension",
                new XElement(
                    ext + "ExtensionContent",
                    new XElement(
                        ds + "Signature",
                        new XAttribute("Id", "Placeholder-Signature"),
                        new XElement(ds + "SignatureValue", "SIMULATED-NOT-A-REAL-SIGNATURE")))));
    }

    private static string BuildDeterministicUuid(int invoiceId)
    {
        var hash = MD5.HashData(Encoding.UTF8.GetBytes($"InvoiceApp-Invoice-{invoiceId}"));
        return new Guid(hash).ToString().ToUpperInvariant();
    }

    private static XElement BuildSupplierParty(XNamespace cac, XNamespace cbc, Invoice invoice)
    {
        var firm = invoice.Firm;
        var branch = invoice.Branch;

        var party = new XElement(cac + "Party");

        if (!string.IsNullOrWhiteSpace(branch?.Website))
        {
            party.Add(new XElement(cbc + "WebsiteURI", branch.Website));
        }

        party.Add(new XElement(
            cac + "PartyIdentification",
            new XElement(cbc + "ID", new XAttribute("schemeID", "VKN"), firm.Vkn ?? string.Empty)));

        party.Add(new XElement(cac + "PartyName", new XElement(cbc + "Name", firm.Name)));

        party.Add(new XElement(
            cac + "PostalAddress",
            new XElement(cbc + "StreetName", branch?.Address ?? string.Empty),
            new XElement(cbc + "CityName", branch?.City ?? string.Empty),
            new XElement(cac + "Country", new XElement(cbc + "Name", "Türkiye"))));

        if (!string.IsNullOrWhiteSpace(branch?.TaxOffice))
        {
            party.Add(new XElement(
                cac + "PartyTaxScheme",
                new XElement(cac + "TaxScheme", new XElement(cbc + "Name", branch.TaxOffice))));
        }

        if (!string.IsNullOrWhiteSpace(branch?.Phone)
            || !string.IsNullOrWhiteSpace(branch?.Fax)
            || !string.IsNullOrWhiteSpace(branch?.Email))
        {
            party.Add(new XElement(
                cac + "Contact",
                string.IsNullOrWhiteSpace(branch?.Phone) ? null : new XElement(cbc + "Telephone", branch.Phone),
                string.IsNullOrWhiteSpace(branch?.Fax) ? null : new XElement(cbc + "Telefax", branch.Fax),
                string.IsNullOrWhiteSpace(branch?.Email) ? null : new XElement(cbc + "ElectronicMail", branch.Email)));
        }

        return new XElement(cac + "AccountingSupplierParty", party);
    }

    private static XElement BuildCustomerParty(XNamespace cac, XNamespace cbc, Customer customer)
    {
        var schemeId = customer.TaxNumber.Length == 11 ? "TCKN" : "VKN";

        var party = new XElement(
            cac + "Party",
            new XElement(
                cac + "PartyIdentification",
                new XElement(cbc + "ID", new XAttribute("schemeID", schemeId), customer.TaxNumber)),
            new XElement(cac + "PartyName", new XElement(cbc + "Name", customer.Title)),
            new XElement(
                cac + "PostalAddress",
                new XElement(cbc + "StreetName", customer.Address),
                new XElement(cac + "Country", new XElement(cbc + "Name", "Türkiye"))));

        if (!string.IsNullOrWhiteSpace(customer.Email))
        {
            party.Add(new XElement(cac + "Contact", new XElement(cbc + "ElectronicMail", customer.Email)));
        }

        return new XElement(cac + "AccountingCustomerParty", party);
    }

    private static XElement BuildTaxTotal(XNamespace cac, XNamespace cbc, List<InvoiceLine> lines)
    {
        var groups = lines
            .GroupBy(l => l.VatRatePercentage)
            .Select(g => new
            {
                Percent = g.Key,
                Taxable = g.Sum(l => Math.Round(l.Quantity * l.Price, 2)),
                Tax = g.Sum(l => Math.Round(Math.Round(l.Quantity * l.Price, 2) * g.Key / 100, 2))
            })
            .ToList();

        var totalTax = groups.Sum(g => g.Tax);

        return new XElement(
            cac + "TaxTotal",
            new XElement(cbc + "TaxAmount", new XAttribute("currencyID", "TRY"), FormatAmount(totalTax)),
            groups.Select(g => new XElement(
                cac + "TaxSubtotal",
                new XElement(cbc + "TaxableAmount", new XAttribute("currencyID", "TRY"), FormatAmount(g.Taxable)),
                new XElement(cbc + "TaxAmount", new XAttribute("currencyID", "TRY"), FormatAmount(g.Tax)),
                new XElement(cbc + "Percent", FormatAmount(g.Percent)),
                new XElement(
                    cac + "TaxCategory",
                    new XElement(cac + "TaxScheme", new XElement(cbc + "TaxTypeCode", VatTaxTypeCode))))));
    }

    private static XElement BuildLegalMonetaryTotal(XNamespace cac, XNamespace cbc, Invoice invoice)
    {
        return new XElement(
            cac + "LegalMonetaryTotal",
            new XElement(cbc + "LineExtensionAmount", new XAttribute("currencyID", "TRY"), FormatAmount(invoice.Subtotal)),
            new XElement(cbc + "TaxExclusiveAmount", new XAttribute("currencyID", "TRY"), FormatAmount(invoice.Subtotal)),
            new XElement(cbc + "TaxInclusiveAmount", new XAttribute("currencyID", "TRY"), FormatAmount(invoice.GrandTotal)),
            new XElement(cbc + "PayableAmount", new XAttribute("currencyID", "TRY"), FormatAmount(invoice.GrandTotal)));
    }

    private static XElement BuildInvoiceLine(XNamespace cac, XNamespace cbc, InvoiceLine line, int lineNumber)
    {
        var lineSubtotal = Math.Round(line.Quantity * line.Price, 2);
        var lineVat = Math.Round(lineSubtotal * line.VatRatePercentage / 100, 2);

        return new XElement(
            cac + "InvoiceLine",
            new XElement(cbc + "ID", lineNumber.ToString(CultureInfo.InvariantCulture)),
            new XElement(cbc + "InvoicedQuantity", FormatQuantity(line.Quantity)),
            new XElement(cbc + "LineExtensionAmount", new XAttribute("currencyID", "TRY"), FormatAmount(lineSubtotal)),
            new XElement(cac + "Item", new XElement(cbc + "Name", line.ItemName)),
            new XElement(
                cac + "Price",
                new XElement(cbc + "PriceAmount", new XAttribute("currencyID", "TRY"), FormatAmount(line.Price))),
            new XElement(
                cac + "TaxTotal",
                new XElement(cbc + "TaxAmount", new XAttribute("currencyID", "TRY"), FormatAmount(lineVat)),
                new XElement(
                    cac + "TaxSubtotal",
                    new XElement(cbc + "TaxableAmount", new XAttribute("currencyID", "TRY"), FormatAmount(lineSubtotal)),
                    new XElement(cbc + "TaxAmount", new XAttribute("currencyID", "TRY"), FormatAmount(lineVat)),
                    new XElement(cbc + "Percent", FormatAmount(line.VatRatePercentage)),
                    new XElement(
                        cac + "TaxCategory",
                        new XElement(cac + "TaxScheme", new XElement(cbc + "TaxTypeCode", VatTaxTypeCode))))));
    }

    private static string FormatAmount(decimal value) => value.ToString("0.00", CultureInfo.InvariantCulture);

    private static string FormatQuantity(decimal value) => value.ToString(CultureInfo.InvariantCulture);
}
