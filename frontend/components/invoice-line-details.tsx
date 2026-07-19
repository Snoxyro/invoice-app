"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { apiFetch } from "@/lib/api";

interface InvoiceLineResponse {
  invoiceLineId: number;
  itemName: string;
  quantity: number;
  price: number;
  vatRateId: number;
  vatRatePercentage: number;
  subtotal: number;
  vatAmount: number;
  lineTotal: number;
}

interface InvoiceDetailResponse {
  invoiceId: number;
  invoiceNumber: string;
  subtotal: number;
  vatTotal: number;
  grandTotal: number;
  lines: InvoiceLineResponse[];
}

interface InvoiceLineDetailsProps {
  invoiceId: number;
}

function formatAmount(value: number): string {
  return value.toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

export function InvoiceLineDetails({ invoiceId }: InvoiceLineDetailsProps) {
  const t = useTranslations("invoices");
  const [invoice, setInvoice] = useState<InvoiceDetailResponse | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [hasError, setHasError] = useState(false);

  useEffect(() => {
    let isCancelled = false;

    async function load() {
      setIsLoading(true);
      setHasError(false);

      try {
        const result = await apiFetch<InvoiceDetailResponse>(`/api/Invoices/${invoiceId}`);

        if (!isCancelled) {
          setInvoice(result);
        }
      } catch {
        if (!isCancelled) {
          setHasError(true);
        }
      } finally {
        if (!isCancelled) {
          setIsLoading(false);
        }
      }
    }

    load();

    return () => {
      isCancelled = true;
    };
  }, [invoiceId]);

  if (isLoading) {
    return <p className="py-2 text-sm text-muted-foreground">{t("loadingLines")}</p>;
  }

  if (hasError || !invoice) {
    return <p className="py-2 text-sm text-destructive">{t("loadLinesError")}</p>;
  }

  return (
    <div className="flex flex-col gap-2">
      <table className="w-full text-sm">
        <thead>
          <tr className="border-b text-left text-muted-foreground">
            <th className="py-1 font-medium">{t("lineItemName")}</th>
            <th className="py-1 font-medium">{t("lineQuantity")}</th>
            <th className="py-1 font-medium">{t("linePrice")}</th>
            <th className="py-1 font-medium">{t("lineVatRate")}</th>
            <th className="py-1 text-right font-medium">{t("lineTotal")}</th>
          </tr>
        </thead>
        <tbody>
          {invoice.lines.map((line) => (
            <tr key={line.invoiceLineId} className="border-b last:border-0">
              <td className="py-1">{line.itemName}</td>
              <td className="py-1">{line.quantity}</td>
              <td className="py-1">{formatAmount(line.price)}</td>
              <td className="py-1">%{line.vatRatePercentage}</td>
              <td className="py-1 text-right">{formatAmount(line.lineTotal)}</td>
            </tr>
          ))}
        </tbody>
      </table>

      <div className="flex flex-col items-end gap-0.5 text-sm">
        <div className="flex w-48 justify-between text-muted-foreground">
          <span>{t("subtotalLabel")}</span>
          <span>{formatAmount(invoice.subtotal)}</span>
        </div>
        <div className="flex w-48 justify-between text-muted-foreground">
          <span>{t("vatTotalLabel")}</span>
          <span>{formatAmount(invoice.vatTotal)}</span>
        </div>
        <div className="flex w-48 justify-between font-semibold">
          <span>{t("grandTotalLabel")}</span>
          <span>{formatAmount(invoice.grandTotal)}</span>
        </div>
      </div>
    </div>
  );
}
