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
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";
import { usePermissions } from "@/contexts/PermissionContext";

interface CustomerResponse {
  customerId: number;
  taxNumber: string;
  title: string;
  address: string;
  email: string;
  phone: string | null;
  branchId: number | null;
  branchName: string | null;
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
  const { canAccessAllBranches, availableBranches } = usePermissions();

  const isEditMode = customer !== null;

  const [taxNumber, setTaxNumber] = useState("");
  const [title, setTitle] = useState("");
  const [address, setAddress] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [branchId, setBranchId] = useState<number | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const defaultBranchId =
    availableBranches.find((b) => b.isHeadquarters)?.branchId ?? availableBranches[0]?.branchId ?? null;

  useEffect(() => {
    if (open) {
      setTaxNumber(customer?.taxNumber ?? "");
      setTitle(customer?.title ?? "");
      setAddress(customer?.address ?? "");
      setEmail(customer?.email ?? "");
      setPhone(customer?.phone ?? "");
      setBranchId(customer ? (customer.branchId ?? null) : defaultBranchId);
      setError(null);
    }
  }, [open, customer, defaultBranchId]);

  function handleBranchChange(value: string | null) {
    if (value) {
      setBranchId(Number(value));
    }
  }

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const payload = { taxNumber, title, address, email, phone: phone.trim() || null, branchId };

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

          <div className="grid grid-cols-2 gap-4">
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
              <Label htmlFor="phone">{t("phoneLabel")}</Label>
              <Input
                id="phone"
                type="tel"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                placeholder="+90 212 000 00 00"
              />
            </div>
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

          {canAccessAllBranches && (
            <div className="flex flex-col gap-2">
              <Label htmlFor="branch-select">{t("columnBranch")}</Label>
              <Select
                value={branchId !== null ? String(branchId) : null}
                onValueChange={handleBranchChange}
              >
                <SelectTrigger id="branch-select" className="w-full">
                  <SelectValue>
                    {(value: string | null) =>
                      availableBranches.find((b) => String(b.branchId) === value)?.name ?? ""
                    }
                  </SelectValue>
                </SelectTrigger>
                <SelectContent alignItemWithTrigger={false}>
                  {availableBranches.map((b) => (
                    <SelectItem key={b.branchId} value={String(b.branchId)}>
                      {b.name}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          )}

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
