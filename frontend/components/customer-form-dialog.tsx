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

interface CustomerResponse {
  customerId: number;
  taxNumber: string;
  title: string;
  address: string;
  email: string;
  createdDate: string;
  updatedDate: string | null;
}

interface CustomerFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  customer: CustomerResponse | null;
  onSuccess: (customer: CustomerResponse) => void;
}

export function CustomerFormDialog({
  open,
  onOpenChange,
  customer,
  onSuccess,
}: CustomerFormDialogProps) {
  const t = useTranslations("customers");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const isEditMode = customer !== null;

  const [taxNumber, setTaxNumber] = useState("");
  const [title, setTitle] = useState("");
  const [address, setAddress] = useState("");
  const [email, setEmail] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (open) {
      setTaxNumber(customer?.taxNumber ?? "");
      setTitle(customer?.title ?? "");
      setAddress(customer?.address ?? "");
      setEmail(customer?.email ?? "");
      setError(null);
    }
  }, [open, customer]);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const payload = { taxNumber, title, address, email };

    try {
      let result: CustomerResponse;

      if (isEditMode) {
        result = await apiFetch<CustomerResponse>(`/api/Customers/${customer.customerId}`, {
          method: "PUT",
          body: JSON.stringify(payload),
        });
      } else {
        result = await apiFetch<CustomerResponse>("/api/Customers", {
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
          <DialogTitle>{isEditMode ? t("editTitle") : t("createTitle")}</DialogTitle>
          <DialogDescription>
            {isEditMode ? t("editDescription") : t("createDescription")}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="flex flex-col gap-4 px-4">
          <div className="flex flex-col gap-2">
            <Label htmlFor="title">{t("titleLabel")}</Label>
            <Input
              id="title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              required
              autoFocus
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="taxNumber">{t("taxNumberLabel")}</Label>
            <Input
              id="taxNumber"
              value={taxNumber}
              onChange={(e) => setTaxNumber(e.target.value.replace(/\D/g, ""))}
              inputMode="numeric"
              required
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="email">{t("emailLabel")}</Label>
            <Input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="address">{t("addressLabel")}</Label>
            <Input
              id="address"
              value={address}
              onChange={(e) => setAddress(e.target.value)}
              required
            />
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