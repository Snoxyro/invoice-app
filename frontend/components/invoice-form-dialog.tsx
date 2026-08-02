"use client";

import { useEffect, useRef, useState, type FormEvent } from "react";
import { useTranslations } from "next-intl";
import { ChevronDown, ChevronRight, Plus, Trash2, X } from "lucide-react";
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

interface InvoiceLineCustomValueResponse {
  label: string;
  value: string;
}

interface InvoiceLineResponse {
  invoiceLineId: number;
  itemName: string;
  quantity: number;
  price: number;
  vatRateId: number;
  vatRatePercentage: number;
  exemptionReason: string | null;
  customValues: InvoiceLineCustomValueResponse[];
}

interface InvoiceResponse {
  invoiceId: number;
  invoiceNumber: string | null;
  invoiceDate: string;
  subtotal: number;
  vatTotal: number;
  grandTotal: number;
  customerId: number;
  customerTitle: string;
  invoiceSeriesId: number;
  status: "Draft" | "Sent";
  createdDate: string;
  updatedDate: string | null;
  lines: InvoiceLineResponse[];
}

interface InvoiceCustomColumn {
  key: string;
  label: string;
}

interface LineItemState {
  key: string;
  itemName: string;
  quantity: string;
  price: string;
  vatRateId: number | null;
  vatRatePercentage: number;
  isExemptionRate: boolean;
  exemptionReason: string;
  customValues: Record<string, string>;
  customValuesExpanded: boolean;
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
  const { vatRates, minInvoiceAmount, maxInvoiceAmount, availableInvoiceSeries } = usePermissions();

  const isEditMode = invoice !== null;
  const keyCounter = useRef(0);

  function generateKey() {
    keyCounter.current += 1;
    return String(keyCounter.current);
  }

  const [invoiceSeriesId, setInvoiceSeriesId] = useState<number | null>(null);
  const [invoiceDate, setInvoiceDate] = useState("");
  const [customerId, setCustomerId] = useState<number | null>(null);
  const [customerLabel, setCustomerLabel] = useState("");
  const [lines, setLines] = useState<LineItemState[]>([]);
  const [customColumns, setCustomColumns] = useState<InvoiceCustomColumn[]>([]);
  const [newColumnLabel, setNewColumnLabel] = useState("");
  const [columnError, setColumnError] = useState<string | null>(null);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const defaultVatRateId = vatRates[0]?.vatRateId ?? null;
  const defaultVatRatePercentage = vatRates[0]?.rate ?? 0;
  const defaultIsExemptionRate = vatRates[0]?.isExemption ?? false;
  const defaultSeriesId = availableInvoiceSeries[0]?.invoiceSeriesId ?? null;

  function buildBlankLine(columns: InvoiceCustomColumn[]): LineItemState {
    return {
      key: generateKey(),
      itemName: "",
      quantity: "1",
      price: "0",
      vatRateId: defaultVatRateId,
      vatRatePercentage: defaultVatRatePercentage,
      isExemptionRate: defaultIsExemptionRate,
      exemptionReason: "",
      customValues: Object.fromEntries(columns.map((c) => [c.key, ""])),
      customValuesExpanded: false,
    };
  }

  useEffect(() => {
    if (!open) {
      return;
    }

    setError(null);
    setColumnError(null);
    setNewColumnLabel("");

    if (invoice) {
      setInvoiceSeriesId(invoice.invoiceSeriesId);
      setInvoiceDate(invoice.invoiceDate.slice(0, 10));
      setCustomerId(invoice.customerId);
      setCustomerLabel(invoice.customerTitle);

      const distinctLabels: string[] = [];
      invoice.lines.forEach((line) => {
        line.customValues.forEach((cv) => {
          if (!distinctLabels.includes(cv.label)) {
            distinctLabels.push(cv.label);
          }
        });
      });

      const columns = distinctLabels.map((label) => ({ key: generateKey(), label }));
      setCustomColumns(columns);

      setLines(
        invoice.lines.map((line) => {
          const valuesByLabel = new Map(line.customValues.map((cv) => [cv.label, cv.value]));
          const customValues: Record<string, string> = {};
          columns.forEach((col) => {
            customValues[col.key] = valuesByLabel.get(col.label) ?? "";
          });

          return {
            key: generateKey(),
            itemName: line.itemName,
            quantity: String(line.quantity),
            price: String(line.price),
            vatRateId: line.vatRateId,
            vatRatePercentage: line.vatRatePercentage,
            isExemptionRate: vatRates.find((v) => v.vatRateId === line.vatRateId)?.isExemption ?? false,
            exemptionReason: line.exemptionReason ?? "",
            customValues,
            customValuesExpanded: columns.some((col) => customValues[col.key]?.trim() !== ""),
          };
        })
      );
      return;
    }

    setInvoiceSeriesId(defaultSeriesId);
    setInvoiceDate("");
    setCustomColumns([]);
    setLines([buildBlankLine([])]);

    if (lockedCustomer) {
      setCustomerId(lockedCustomer.customerId);
      setCustomerLabel(`${lockedCustomer.title} — ${lockedCustomer.taxNumber}`);
    } else {
      setCustomerId(null);
      setCustomerLabel("");
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, invoice, lockedCustomer, defaultSeriesId]);

  function addLine() {
    setLines((prev) => [...prev, buildBlankLine(customColumns)]);
  }

  function removeLine(key: string) {
    setLines((prev) => prev.filter((line) => line.key !== key));
  }

  function updateLine(key: string, field: "itemName" | "quantity" | "price", value: string) {
    setLines((prev) => prev.map((line) => (line.key === key ? { ...line, [field]: value } : line)));
  }

  function updateLineVatRate(key: string, vatRateId: number) {
    const option = vatRates.find((v) => v.vatRateId === vatRateId);
    const rate = option?.rate ?? 0;
    const isExemptionRate = option?.isExemption ?? false;

    setLines((prev) =>
      prev.map((line) =>
        line.key === key
          ? {
              ...line,
              vatRateId,
              vatRatePercentage: rate,
              isExemptionRate,
              exemptionReason: isExemptionRate ? line.exemptionReason : "",
            }
          : line
      )
    );
  }

  function updateLineExemptionReason(key: string, value: string) {
    setLines((prev) =>
      prev.map((line) => (line.key === key ? { ...line, exemptionReason: value } : line))
    );
  }

  function toggleLineCustomValues(key: string) {
    setLines((prev) =>
      prev.map((line) =>
        line.key === key ? { ...line, customValuesExpanded: !line.customValuesExpanded } : line
      )
    );
  }

  function updateLineCustomValue(lineKey: string, columnKey: string, value: string) {
    setLines((prev) =>
      prev.map((line) =>
        line.key === lineKey
          ? { ...line, customValues: { ...line.customValues, [columnKey]: value } }
          : line
      )
    );
  }

  function addCustomColumn() {
    const label = newColumnLabel.trim();

    if (label === "") {
      return;
    }

    const isDuplicate = customColumns.some((c) => c.label.toLowerCase() === label.toLowerCase());

    if (isDuplicate) {
      setColumnError(t("customFieldDuplicateError"));
      return;
    }

    const key = generateKey();
    setCustomColumns((prev) => [...prev, { key, label }]);
    setLines((prev) =>
      prev.map((line) => ({
        ...line,
        customValues: { ...line.customValues, [key]: "" },
        customValuesExpanded: true,
      }))
    );
    setNewColumnLabel("");
    setColumnError(null);
  }

  function removeCustomColumn(key: string) {
    setCustomColumns((prev) => prev.filter((c) => c.key !== key));
    setLines((prev) =>
      prev.map((line) => {
        const rest = { ...line.customValues };
        delete rest[key];
        return { ...line, customValues: rest };
      })
    );
  }

  function handleSeriesChange(value: string | null) {
    if (value) {
      setInvoiceSeriesId(Number(value));
    }
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

  const seriesSelectOptions =
    invoiceSeriesId !== null && !availableInvoiceSeries.some((s) => s.invoiceSeriesId === invoiceSeriesId)
      ? [...availableInvoiceSeries, { invoiceSeriesId, prefix: t("unknownSeriesFallback") }]
      : availableInvoiceSeries;

  const showSeriesSelect = seriesSelectOptions.length > 1;

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();

    if (customerId === null) {
      setError(t("customerRequiredError"));
      return;
    }

    if (invoiceSeriesId === null) {
      setError(t("seriesRequiredError"));
      return;
    }

    if (lines.length === 0 || lines.some((line) => line.itemName.trim() === "" || line.vatRateId === null)) {
      setError(t("linesRequiredError"));
      return;
    }

    if (lines.some((line) => line.isExemptionRate && line.exemptionReason.trim() === "")) {
      setError(t("exemptionReasonRequiredError"));
      return;
    }

    setIsSubmitting(true);
    setError(null);

    const payload = {
      customerId,
      invoiceSeriesId,
      invoiceDate,
      lines: lines.map((line) => ({
        itemName: line.itemName,
        quantity: Number(line.quantity),
        price: Number(line.price),
        vatRateId: line.vatRateId,
        exemptionReason: line.isExemptionRate ? line.exemptionReason.trim() : null,
        customValues: customColumns
          .filter((col) => (line.customValues[col.key] ?? "").trim() !== "")
          .map((col) => ({ label: col.label, value: line.customValues[col.key] })),
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
            <DialogTitle className="flex items-center gap-2">
              {isEditMode ? t("editTitle") : t("createTitle")}
              {isEditMode && (
                <span className="rounded bg-muted px-1.5 py-0.5 text-xs text-muted-foreground">
                  {t("draftBadge")}
                </span>
              )}
            </DialogTitle>
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

            <div className={showSeriesSelect ? "grid grid-cols-2 gap-4" : "flex flex-col gap-2"}>
              {showSeriesSelect && (
                <div className="flex flex-col gap-2">
                  <Label htmlFor="series-select">{t("seriesLabel")}</Label>
                  <Select
                    value={invoiceSeriesId !== null ? String(invoiceSeriesId) : null}
                    onValueChange={handleSeriesChange}
                  >
                    <SelectTrigger id="series-select" className="w-full">
                      <SelectValue>
                        {(value: string | null) =>
                          seriesSelectOptions.find((s) => String(s.invoiceSeriesId) === value)?.prefix ?? ""
                        }
                      </SelectValue>
                    </SelectTrigger>
                    <SelectContent alignItemWithTrigger={false}>
                      {seriesSelectOptions.map((s) => (
                        <SelectItem key={s.invoiceSeriesId} value={String(s.invoiceSeriesId)}>
                          {s.prefix}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              )}
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

            {!isEditMode && availableInvoiceSeries.length === 0 && (
              <p className="text-sm text-destructive">{t("noActiveSeriesError")}</p>
            )}

            <div className="flex flex-col gap-2 rounded-md border p-3">
              <Label>{t("customColumnsLabel")}</Label>
              <p className="text-xs text-muted-foreground">{t("customColumnsHint")}</p>

              {customColumns.length > 0 && (
                <div className="flex flex-wrap gap-1.5">
                  {customColumns.map((col) => (
                    <span
                      key={col.key}
                      className="flex items-center gap-1 rounded bg-muted px-2 py-1 text-xs"
                    >
                      {col.label}
                      <button
                        type="button"
                        onClick={() => removeCustomColumn(col.key)}
                        className="text-muted-foreground hover:text-destructive"
                      >
                        <X className="size-3" />
                      </button>
                    </span>
                  ))}
                </div>
              )}

              <div className="flex items-center gap-2">
                <Input
                  className="flex-1"
                  value={newColumnLabel}
                  onChange={(e) => {
                    setNewColumnLabel(e.target.value);
                    setColumnError(null);
                  }}
                  onKeyDown={(e) => {
                    if (e.key === "Enter") {
                      e.preventDefault();
                      addCustomColumn();
                    }
                  }}
                  placeholder={t("newColumnPlaceholder")}
                />
                <Button type="button" variant="outline" size="sm" onClick={addCustomColumn}>
                  <Plus />
                  {t("addColumnButton")}
                </Button>
              </div>

              {columnError && <p className="text-xs text-destructive">{columnError}</p>}
            </div>

            <div className="flex flex-col gap-2">
              <Label>{t("linesLabel")}</Label>

              <div className="flex gap-2 pr-9 text-xs text-muted-foreground">
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
                    ? [
                        ...vatRates,
                        { vatRateId: line.vatRateId, rate: line.vatRatePercentage, isExemption: line.isExemptionRate },
                      ]
                    : vatRates;
                const filledValueCount = customColumns.filter(
                  (col) => (line.customValues[col.key] ?? "").trim() !== ""
                ).length;

                return (
                  <div key={line.key} className="flex flex-col gap-2 rounded-md border p-2">
                    <div className="flex items-center gap-2">
                      <Input
                        className="flex-1"
                        value={line.itemName}
                        onChange={(e) => updateLine(line.key, "itemName", e.target.value)}
                        placeholder={t("lineItemName")}
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
                              {v.isExemption ? ` — ${t("exemptionRateSuffix")}` : ""}
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

                    {line.isExemptionRate && (
                      <div className="flex flex-col gap-1">
                        <Label htmlFor={`exemption-${line.key}`} className="text-xs">
                          {t("exemptionReasonLabel")} <span className="text-destructive">*</span>
                        </Label>
                        <Input
                          id={`exemption-${line.key}`}
                          value={line.exemptionReason}
                          onChange={(e) => updateLineExemptionReason(line.key, e.target.value)}
                          placeholder={t("exemptionReasonPlaceholder")}
                          required
                        />
                      </div>
                    )}

                    {customColumns.length > 0 && (
                      <div>
                        <button
                          type="button"
                          onClick={() => toggleLineCustomValues(line.key)}
                          className="flex items-center gap-1 text-xs text-muted-foreground hover:text-foreground"
                        >
                          {line.customValuesExpanded ? (
                            <ChevronDown className="size-3.5" />
                          ) : (
                            <ChevronRight className="size-3.5" />
                          )}
                          {t("customFieldsToggle")}
                          {filledValueCount > 0 && (
                            <span className="rounded bg-muted px-1.5 py-0.5">{filledValueCount}</span>
                          )}
                        </button>

                        {line.customValuesExpanded && (
                          <div className="mt-2 grid grid-cols-2 gap-2 border-l-2 pl-3">
                            {customColumns.map((col) => (
                              <div key={col.key} className="flex flex-col gap-1">
                                <Label className="text-xs text-muted-foreground">{col.label}</Label>
                                <Input
                                  value={line.customValues[col.key] ?? ""}
                                  onChange={(e) =>
                                    updateLineCustomValue(line.key, col.key, e.target.value)
                                  }
                                  placeholder={t("customFieldValuePlaceholder")}
                                />
                              </div>
                            ))}
                          </div>
                        )}
                      </div>
                    )}
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
              <Button
                type="submit"
                disabled={isSubmitting || (!isEditMode && availableInvoiceSeries.length === 0)}
              >
                {isSubmitting ? tCommon("processing") : t("saveDraftButton")}
              </Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      <CustomerPickerDialog open={pickerOpen} onOpenChange={setPickerOpen} onSelect={handleCustomerSelect} />
    </>
  );
}