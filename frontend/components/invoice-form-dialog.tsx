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
import { CustomerPickerDialog } from "@/components/customer-picker-dialog";
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";

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
}

interface InvoiceResponse {
  invoiceId: number;
  invoiceNumber: string;
  invoiceDate: string;
  totalAmount: number;
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
}

interface InvoiceFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  invoice: InvoiceResponse | null;
  lockedCustomer?: CustomerResponse | null;
  onSuccess: () => void;
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
        }))
      );
      return;
    }

    setInvoiceNumber("");
    setInvoiceDate("");
    setLines([{ key: generateKey(), itemName: "", quantity: "1", price: "0" }]);

    if (lockedCustomer) {
      setCustomerId(lockedCustomer.customerId);
      setCustomerLabel(`${lockedCustomer.title} — ${lockedCustomer.taxNumber}`);
    } else {
      setCustomerId(null);
      setCustomerLabel("");
    }
  }, [open, invoice, lockedCustomer]);

  function addLine() {
    setLines((prev) => [...prev, { key: generateKey(), itemName: "", quantity: "1", price: "0" }]);
  }

  function removeLine(key: string) {
    setLines((prev) => prev.filter((line) => line.key !== key));
  }

  function updateLine(key: string, field: "itemName" | "quantity" | "price", value: string) {
    setLines((prev) =>
      prev.map((line) => (line.key === key ? { ...line, [field]: value } : line))
    );
  }

  function handleCustomerSelect(customer: CustomerResponse) {
    setCustomerId(customer.customerId);
    setCustomerLabel(`${customer.title} — ${customer.taxNumber}`);
  }

  const total = lines.reduce(
    (sum, line) => sum + (Number(line.quantity) || 0) * (Number(line.price) || 0),
    0
  );

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();

    if (customerId === null) {
      setError(t("customerRequiredError"));
      return;
    }

    if (lines.length === 0 || lines.some((line) => line.itemName.trim() === "")) {
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
        <DialogContent className="sm:max-w-2xl">
          <DialogHeader>
            <DialogTitle>{isEditMode ? t("editTitle") : t("createTitle")}</DialogTitle>
            <DialogDescription>
              {isEditMode ? t("editDescription") : t("createDescription")}
            </DialogDescription>
          </DialogHeader>

          <form onSubmit={handleSubmit} className="flex flex-col gap-4 px-4">
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
                <span className="w-24">{t("lineQuantity")}</span>
                <span className="w-28">{t("linePrice")}</span>
                <span className="w-8" />
              </div>

              {lines.map((line) => (
                <div key={line.key} className="flex items-center gap-2">
                  <Input
                    className="flex-1"
                    value={line.itemName}
                    onChange={(e) => updateLine(line.key, "itemName", e.target.value)}
                  />
                  <Input
                    className="w-24"
                    type="number"
                    step="1"
                    min="0"
                    value={line.quantity}
                    onChange={(e) => updateLine(line.key, "quantity", e.target.value)}
                  />
                  <Input
                    className="w-28"
                    type="number"
                    step="0.01"
                    min="0"
                    value={line.price}
                    onChange={(e) => updateLine(line.key, "price", e.target.value)}
                  />
                  <Button
                    type="button"
                    variant="ghost"
                    size="icon-sm"
                    onClick={() => removeLine(line.key)}
                  >
                    <Trash2 />
                  </Button>
                </div>
              ))}

              <Button
                type="button"
                variant="outline"
                size="sm"
                onClick={addLine}
                className="self-start"
              >
                <Plus />
                {t("addLineButton")}
              </Button>
            </div>

            <div className="flex justify-end text-sm font-medium">
              {t("lineTotal")}:{" "}
              {total.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })}
            </div>

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

      <CustomerPickerDialog
        open={pickerOpen}
        onOpenChange={setPickerOpen}
        onSelect={handleCustomerSelect}
      />
    </>
  );
}