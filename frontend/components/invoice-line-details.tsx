"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { apiFetch } from "@/lib/api";

interface InvoiceLineResponse {
  invoiceLineId: number;
  itemName: string;
  quantity: number;
  price: number;
}

interface InvoiceDetailResponse {
  invoiceId: number;
  invoiceNumber: string;
  lines: InvoiceLineResponse[];
}

interface InvoiceLineDetailsProps {
  invoiceId: number;
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
    <table className="w-full text-sm">
      <thead>
        <tr className="border-b text-left text-muted-foreground">
          <th className="py-1 font-medium">{t("lineItemName")}</th>
          <th className="py-1 font-medium">{t("lineQuantity")}</th>
          <th className="py-1 font-medium">{t("linePrice")}</th>
          <th className="py-1 font-medium">{t("lineTotal")}</th>
        </tr>
      </thead>
      <tbody>
        {invoice.lines.map((line) => (
          <tr key={line.invoiceLineId} className="border-b last:border-0">
            <td className="py-1">{line.itemName}</td>
            <td className="py-1">{line.quantity}</td>
            <td className="py-1">
              {line.price.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })}
            </td>
            <td className="py-1">
              {(line.quantity * line.price).toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
              })}
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}