"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { FileCode, FileText } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { apiDownload, apiFetch, apiFetchText } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";

interface InvoicePreviewDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  invoiceId: number | null;
  mode: "view" | "send";
  onSent?: () => void;
}

export function InvoicePreviewDialog({
  open,
  onOpenChange,
  invoiceId,
  mode,
  onSent,
}: InvoicePreviewDialogProps) {
  const t = useTranslations("invoices");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const [html, setHtml] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [isSending, setIsSending] = useState(false);
  const [isDownloading, setIsDownloading] = useState<"xml" | "pdf" | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!open || invoiceId === null) {
      return;
    }

    let isCancelled = false;

    async function load() {
      setIsLoading(true);
      setError(null);
      setHtml(null);

      try {
        const result = await apiFetchText(`/api/Invoices/${invoiceId}/preview`);

        if (!isCancelled) {
          setHtml(result);
        }
      } catch (err) {
        if (!isCancelled) {
          setError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
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
  }, [open, invoiceId]);

  async function handleConfirmSend() {
    if (invoiceId === null) {
      return;
    }

    setIsSending(true);
    setError(null);

    try {
      await apiFetch(`/api/Invoices/${invoiceId}/send`, { method: "POST" });
      onSent?.();
      onOpenChange(false);
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setIsSending(false);
    }
  }

  async function handleDownload(format: "xml" | "pdf") {
    if (invoiceId === null) {
      return;
    }

    setIsDownloading(format);
    setError(null);

    try {
      await apiDownload(`/api/Invoices/${invoiceId}/${format}`, `fatura-${invoiceId}.${format}`);
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setIsDownloading(null);
    }
  }

  function handleOpenChange(next: boolean) {
    if (!isSending) {
      onOpenChange(next);
    }
  }

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogContent className="sm:max-w-4xl">
        <DialogHeader>
          <DialogTitle>{mode === "send" ? t("sendConfirmTitle") : t("previewTitle")}</DialogTitle>
          <DialogDescription>
            {mode === "send" ? t("sendConfirmDescription") : t("previewDescription")}
          </DialogDescription>
        </DialogHeader>

        <div className="px-4">
          {isLoading && (
            <p className="py-8 text-center text-sm text-muted-foreground">{t("previewLoading")}</p>
          )}
          {!isLoading && html !== null && (
            <iframe
              srcDoc={html}
              className="h-[60vh] w-full rounded-md border bg-white"
              sandbox="allow-scripts"
            />
          )}
        </div>

        {error && <p className="px-4 text-sm text-destructive">{error}</p>}

        <DialogFooter>
          <div className="mr-auto flex items-center gap-1">
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => handleDownload("xml")}
              disabled={isLoading || isDownloading !== null}
            >
              <FileCode />
              {isDownloading === "xml" ? tCommon("processing") : t("downloadXmlButton")}
            </Button>
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => handleDownload("pdf")}
              disabled={isLoading || isDownloading !== null}
            >
              <FileText />
              {isDownloading === "pdf" ? tCommon("processing") : t("downloadPdfButton")}
            </Button>
          </div>
          <Button
            type="button"
            variant="outline"
            onClick={() => onOpenChange(false)}
            disabled={isSending}
          >
            {mode === "send" ? tCommon("cancel") : tCommon("close")}
          </Button>
          {mode === "send" && (
            <Button type="button" onClick={handleConfirmSend} disabled={isSending || isLoading}>
              {isSending ? tCommon("processing") : t("confirmSendButton")}
            </Button>
          )}
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
