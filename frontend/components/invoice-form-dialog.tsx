"use client";

import { useEffect, useRef, useState, type FormEvent } from "react";
import { useTranslations } from "next-intl";
import { Plus, Trash2 } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { CustomerPickerDialog } from "@/components/customer-picker-dialog";
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";
import { usePermissions } from "@/contexts/PermissionContext";

interface CustomerResponse {
  customerId: number;
  taxNumber: string;
  title: string;
  address: string;
  email: string;
  createdDate: string;
  updatedDate: string | null;
}

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

interface InvoiceResponse {
  invoiceId: number;
  invoiceNumber: string;
  invoiceDate: string;
  subtotal: number;
  vatTotal: number;
  grandTotal: number;
  customerId: number;
  customerTitle: string;
  createdDate: string;
  updatedDate: string | null;
  lines: InvoiceLineResponse[];
}

interface LineItemState {
  key: string;
  itemName: string;
  quantity: string;
  price: string;
  vatRateId: number | null;
  vatRatePercentage: number;
}

interface InvoiceFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  invoice: InvoiceResponse | null;
  lockedCustomer?: CustomerResponse | null;
  onSuccess: () => void;
}

function formatAmount(value: number): string {
  return value.toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

export function InvoiceFormDialog({
  open,
  onOpenChange,
  invoice,
  lockedCustomer,
  onSuccess,
}: InvoiceFormDialogProps) {
  const t = useTranslations("invoices");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");
  const { vatRates, minInvoiceAmount, maxInvoiceAmount } = usePermissions();

  const isEditMode = invoice !== null;
  const keyCounter = useRef(0);

  function generateKey() {
    keyCounter.current += 1;
    return String(keyCounter.current);
  }

  const [invoiceNumber, setInvoiceNumber] = useState("");
  const [invoiceDate, setInvoiceDate] = useState("");
  const [customerId, setCustomerId] = useState<number | null>(null);
  const [customerLabel, setCustomerLabel] = useState("");
  const [lines, setLines] = useState<LineItemState[]>([]);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const defaultVatRateId = vatRates[0]?.vatRateId ?? null;
  const defaultVatRatePercentage = vatRates[0]?.rate ?? 0;

  useEffect(() => {
    if (!open) {
      return;
    }

    setError(null);

    if (invoice) {
      setInvoiceNumber(invoice.invoiceNumber);
      setInvoiceDate(invoice.invoiceDate.slice(0, 10));
      setCustomerId(invoice.customerId);
      setCustomerLabel(invoice.customerTitle);
      setLines(
        invoice.lines.map((line) => ({
          key: generateKey(),
          itemName: line.itemName,
          quantity: String(line.quantity),
          price: String(line.price),
          vatRateId: line.vatRateId,
          vatRatePercentage: line.vatRatePercentage,
        }))
      );
      return;
    }

    setInvoiceNumber("");
    setInvoiceDate("");
    setLines([
      {
        key: generateKey(),
        itemName: "",
        quantity: "1",
        price: "0",
        vatRateId: defaultVatRateId,
        vatRatePercentage: defaultVatRatePercentage,
      },
    ]);

    if (lockedCustomer) {
      setCustomerId(lockedCustomer.customerId);
      setCustomerLabel(`${lockedCustomer.title} — ${lockedCustomer.taxNumber}`);
    } else {
      setCustomerId(null);
      setCustomerLabel("");
    }
  }, [open, invoice, lockedCustomer]);

  function addLine() {
    setLines((prev) => [
      ...prev,
      {
        key: generateKey(),
        itemName: "",
        quantity: "1",
        price: "0",
        vatRateId: defaultVatRateId,
        vatRatePercentage: defaultVatRatePercentage,
      },
    ]);
  }

  function removeLine(key: string) {
    setLines((prev) => prev.filter((line) => line.key !== key));
  }

  function updateLine(key: string, field: "itemName" | "quantity" | "price", value: string) {
    setLines((prev) => prev.map((line) => (line.key === key ? { ...line, [field]: value } : line)));
  }

  function updateLineVatRate(key: string, vatRateId: number) {
    const rate = vatRates.find((v) => v.vatRateId === vatRateId)?.rate ?? 0;

    setLines((prev) =>
      prev.map((line) =>
        line.key === key ? { ...line, vatRateId, vatRatePercentage: rate } : line
      )
    );
  }

  function handleCustomerSelect(customer: CustomerResponse) {
    setCustomerId(customer.customerId);
    setCustomerLabel(`${customer.title} — ${customer.taxNumber}`);
  }

  function roundToCents(value: number): number {
    return Math.round(value * 100) / 100;
  }

  function lineTotals(line: LineItemState) {
    const quantity = Number(line.quantity) || 0;
    const price = Number(line.price) || 0;
    const subtotal = roundToCents(quantity * price);
    const vatAmount = roundToCents(subtotal * (line.vatRatePercentage / 100));

    return { subtotal, vatAmount, lineTotal: subtotal + vatAmount };
  }

  const totals = lines.reduce(
    (acc, line) => {
      const { subtotal, vatAmount, lineTotal } = lineTotals(line);

      return {
        subtotal: acc.subtotal + subtotal,
        vatTotal: acc.vatTotal + vatAmount,
        grandTotal: acc.grandTotal + lineTotal,
      };
    },
    { subtotal: 0, vatTotal: 0, grandTotal: 0 }
  );

  let limitHint: string | null = null;

  if (minInvoiceAmount !== null && totals.grandTotal < minInvoiceAmount) {
    limitHint = t("belowMinimumHint", { min: minInvoiceAmount });
  } else if (maxInvoiceAmount !== null && totals.grandTotal > maxInvoiceAmount) {
    limitHint = t("aboveMaximumHint", { max: maxInvoiceAmount });
  }

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();

    if (customerId === null) {
      setError(t("customerRequiredError"));
      return;
    }

    if (lines.length === 0 || lines.some((line) => line.itemName.trim() === "" || line.vatRateId === null)) {
      setError(t("linesRequiredError"));
      return;
    }

    setIsSubmitting(true);
    setError(null);

    const payload = {
      customerId,
      invoiceNumber,
      invoiceDate,
      lines: lines.map((line) => ({
        itemName: line.itemName,
        quantity: Number(line.quantity),
        price: Number(line.price),
        vatRateId: line.vatRateId,
      })),
    };

    try {
      if (isEditMode) {
        await apiFetch(`/api/Invoices/${invoice.invoiceId}`, {
          method: "PUT",
          body: JSON.stringify(payload),
        });
      } else {
        await apiFetch("/api/Invoices", {
          method: "POST",
          body: JSON.stringify(payload),
        });
      }

      onSuccess();
      onOpenChange(false);
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setIsSubmitting(false);
    }
  }

  function handleOpenChange(next: boolean) {
    if (!isSubmitting) {
      onOpenChange(next);
    }
  }

  return (
    <>
      <Dialog open={open} onOpenChange={handleOpenChange}>
        <DialogContent className="sm:max-w-3xl">
          <DialogHeader>
            <DialogTitle>{isEditMode ? t("editTitle") : t("createTitle")}</DialogTitle>
            <DialogDescription>
              {isEditMode ? t("editDescription") : t("createDescription")}
            </DialogDescription>
          </DialogHeader>

          <form
            onSubmit={handleSubmit}
            className="flex max-h-[75vh] flex-col gap-4 overflow-y-auto px-4"
          >
            <div className="flex flex-col gap-2">
              <Label>{t("customerLabel")}</Label>
              {lockedCustomer ? (
                <p className="rounded-md border px-3 py-2 text-sm">{customerLabel}</p>
              ) : (
                <div className="flex items-center gap-2">
                  <p className="flex-1 rounded-md border px-3 py-2 text-sm text-muted-foreground">
                    {customerLabel || t("noCustomerSelected")}
                  </p>
                  <Button type="button" variant="outline" onClick={() => setPickerOpen(true)}>
                    {customerId ? t("changeCustomerButton") : t("selectCustomerButton")}
                  </Button>
                </div>
              )}
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="flex flex-col gap-2">
                <Label htmlFor="invoiceNumber">{t("columnInvoiceNumber")}</Label>
                <Input
                  id="invoiceNumber"
                  value={invoiceNumber}
                  onChange={(e) => setInvoiceNumber(e.target.value)}
                  required
                />
              </div>
              <div className="flex flex-col gap-2">
                <Label htmlFor="invoiceDate">{t("columnInvoiceDate")}</Label>
                <Input
                  id="invoiceDate"
                  type="date"
                  value={invoiceDate}
                  onChange={(e) => setInvoiceDate(e.target.value)}
                  required
                />
              </div>
            </div>

            <div className="flex flex-col gap-2">
              <Label>{t("linesLabel")}</Label>

              <div className="flex gap-2 text-xs text-muted-foreground">
                <span className="flex-1">{t("lineItemName")}</span>
                <span className="w-20">{t("lineQuantity")}</span>
                <span className="w-24">{t("linePrice")}</span>
                <span className="w-28">{t("lineVatRate")}</span>
                <span className="w-24 text-right">{t("lineTotal")}</span>
                <span className="w-8" />
              </div>

              {lines.map((line) => {
                const { lineTotal } = lineTotals(line);
                const hasCurrentRateInList = vatRates.some((v) => v.vatRateId === line.vatRateId);
                const selectOptions =
                  line.vatRateId !== null && !hasCurrentRateInList
                    ? [...vatRates, { vatRateId: line.vatRateId, rate: line.vatRatePercentage }]
                    : vatRates;

                return (
                  <div key={line.key} className="flex items-center gap-2">
                    <Input
                      className="flex-1"
                      value={line.itemName}
                      onChange={(e) => updateLine(line.key, "itemName", e.target.value)}
                    />
                    <Input
                      className="w-20"
                      type="number"
                      step="1"
                      min="0"
                      value={line.quantity}
                      onChange={(e) => updateLine(line.key, "quantity", e.target.value)}
                    />
                    <Input
                      className="w-24"
                      type="number"
                      step="0.01"
                      min="0"
                      value={line.price}
                      onChange={(e) => updateLine(line.key, "price", e.target.value)}
                    />
                    <Select
                      value={line.vatRateId !== null ? String(line.vatRateId) : null}
                      onValueChange={(value) => value && updateLineVatRate(line.key, Number(value))}
                    >
                      <SelectTrigger className="w-28">
                        <SelectValue>
                          {line.vatRateId !== null ? `%${line.vatRatePercentage}` : ""}
                        </SelectValue>
                      </SelectTrigger>
                      <SelectContent alignItemWithTrigger={false}>
                        {selectOptions.map((v) => (
                          <SelectItem key={v.vatRateId} value={String(v.vatRateId)}>
                            %{v.rate}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <span className="w-24 text-right text-sm">{formatAmount(lineTotal)}</span>
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon-sm"
                      onClick={() => removeLine(line.key)}
                    >
                      <Trash2 />
                    </Button>
                  </div>
                );
              })}

              <Button type="button" variant="outline" size="sm" onClick={addLine} className="self-start">
                <Plus />
                {t("addLineButton")}
              </Button>
            </div>

            <div className="flex flex-col items-end gap-1 text-sm">
              <div className="flex w-48 justify-between text-muted-foreground">
                <span>{t("subtotalLabel")}</span>
                <span>{formatAmount(totals.subtotal)}</span>
              </div>
              <div className="flex w-48 justify-between text-muted-foreground">
                <span>{t("vatTotalLabel")}</span>
                <span>{formatAmount(totals.vatTotal)}</span>
              </div>
              <div className="flex w-48 justify-between font-semibold">
                <span>{t("grandTotalLabel")}</span>
                <span>{formatAmount(totals.grandTotal)}</span>
              </div>
            </div>

            {limitHint && <p className="text-sm text-amber-600">{limitHint}</p>}

            {error && <p className="text-sm text-destructive">{error}</p>}

            <DialogFooter>
              <Button
                type="button"
                variant="outline"
                onClick={() => onOpenChange(false)}
                disabled={isSubmitting}
              >
                {tCommon("cancel")}
              </Button>
              <Button type="submit" disabled={isSubmitting}>
                {isSubmitting ? tCommon("processing") : tCommon("save")}
              </Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      <CustomerPickerDialog open={pickerOpen} onOpenChange={setPickerOpen} onSelect={handleCustomerSelect} />
    </>
  );
}