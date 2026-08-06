"use client";

import { useEffect, useState, type FormEvent } from "react";
import { useTranslations } from "next-intl";
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
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";

export interface BankAccountResponse {
  bankAccountId: number;
  bankName: string;
  currency: string;
  iban: string;
  createdDate: string;
  updatedDate: string | null;
}

interface BankAccountFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  bankAccount: BankAccountResponse | null;
  onSuccess: (bankAccount: BankAccountResponse) => void;
}

export function BankAccountFormDialog({
  open,
  onOpenChange,
  bankAccount,
  onSuccess,
}: BankAccountFormDialogProps) {
  const t = useTranslations("invoiceCustomization");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const isEditMode = bankAccount !== null;

  const [bankName, setBankName] = useState("");
  const [currency, setCurrency] = useState("");
  const [iban, setIban] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (open) {
      setBankName(bankAccount?.bankName ?? "");
      setCurrency(bankAccount?.currency ?? "TRY");
      setIban(bankAccount?.iban ?? "");
      setError(null);
    }
  }, [open, bankAccount]);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const payload = { bankName, currency, iban };

    try {
      let result: BankAccountResponse;

      if (isEditMode) {
        result = await apiFetch<BankAccountResponse>(
          `/api/BankAccounts/${bankAccount.bankAccountId}`,
          { method: "PUT", body: JSON.stringify(payload) }
        );
      } else {
        result = await apiFetch<BankAccountResponse>("/api/BankAccounts", {
          method: "POST",
          body: JSON.stringify(payload),
        });
      }

      onSuccess(result);
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
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{isEditMode ? t("bankEditTitle") : t("bankCreateTitle")}</DialogTitle>
          <DialogDescription>
            {isEditMode ? t("bankEditDescription") : t("bankCreateDescription")}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="flex flex-col gap-4 px-4">
          <div className="flex flex-col gap-2">
            <Label htmlFor="bankName">{t("bankNameLabel")}</Label>
            <Input
              id="bankName"
              value={bankName}
              onChange={(e) => setBankName(e.target.value)}
              required
              autoFocus
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="flex flex-col gap-2">
              <Label htmlFor="currency">{t("currencyLabel")}</Label>
              <Input
                id="currency"
                value={currency}
                onChange={(e) => setCurrency(e.target.value.toUpperCase())}
                maxLength={3}
                placeholder="TRY"
                required
              />
            </div>
            <div className="flex flex-col gap-2">
              <Label htmlFor="iban">{t("ibanLabel")}</Label>
              <Input
                id="iban"
                value={iban}
                onChange={(e) => setIban(e.target.value.toUpperCase())}
                placeholder="TR00 0000 0000 0000 0000 0000 00"
                required
              />
            </div>
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
  );
}
