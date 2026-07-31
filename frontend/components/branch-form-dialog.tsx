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

interface BranchResponse {
  branchId: number;
  name: string;
  isHeadquarters: boolean;
  address: string | null;
  city: string | null;
  taxOffice: string | null;
  phone: string | null;
  fax: string | null;
  email: string | null;
  website: string | null;
  createdDate: string;
  updatedDate: string | null;
}

interface BranchFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  branch: BranchResponse | null;
  onSuccess: (branch: BranchResponse) => void;
}

export function BranchFormDialog({ open, onOpenChange, branch, onSuccess }: BranchFormDialogProps) {
  const t = useTranslations("branches");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const isEditMode = branch !== null;

  const [name, setName] = useState("");
  const [address, setAddress] = useState("");
  const [city, setCity] = useState("");
  const [taxOffice, setTaxOffice] = useState("");
  const [phone, setPhone] = useState("");
  const [fax, setFax] = useState("");
  const [email, setEmail] = useState("");
  const [website, setWebsite] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (open) {
      setName(branch?.name ?? "");
      setAddress(branch?.address ?? "");
      setCity(branch?.city ?? "");
      setTaxOffice(branch?.taxOffice ?? "");
      setPhone(branch?.phone ?? "");
      setFax(branch?.fax ?? "");
      setEmail(branch?.email ?? "");
      setWebsite(branch?.website ?? "");
      setError(null);
    }
  }, [open, branch]);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const payload = {
      name,
      address: address || null,
      city: city || null,
      taxOffice: taxOffice || null,
      phone: phone || null,
      fax: fax || null,
      email: email || null,
      website: website || null,
    };

    try {
      let result: BranchResponse;

      if (isEditMode) {
        result = await apiFetch<BranchResponse>(`/api/Branches/${branch.branchId}`, {
          method: "PUT",
          body: JSON.stringify(payload),
        });
      } else {
        result = await apiFetch<BranchResponse>("/api/Branches", {
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
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle>{isEditMode ? t("editTitle") : t("createTitle")}</DialogTitle>
          <DialogDescription>
            {isEditMode ? t("editDescription") : t("createDescription")}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="flex max-h-[70vh] flex-col gap-4 overflow-y-auto px-4">
          <div className="flex flex-col gap-2">
            <Label htmlFor="branchName">{t("nameLabel")}</Label>
            <Input
              id="branchName"
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
              autoFocus
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="flex flex-col gap-2">
              <Label htmlFor="city">{t("cityLabel")}</Label>
              <Input id="city" value={city} onChange={(e) => setCity(e.target.value)} />
            </div>
            <div className="flex flex-col gap-2">
              <Label htmlFor="taxOffice">{t("taxOfficeLabel")}</Label>
              <Input id="taxOffice" value={taxOffice} onChange={(e) => setTaxOffice(e.target.value)} />
            </div>
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="address">{t("addressLabel")}</Label>
            <Input id="address" value={address} onChange={(e) => setAddress(e.target.value)} />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="flex flex-col gap-2">
              <Label htmlFor="phone">{t("phoneLabel")}</Label>
              <Input id="phone" value={phone} onChange={(e) => setPhone(e.target.value)} />
            </div>
            <div className="flex flex-col gap-2">
              <Label htmlFor="fax">{t("faxLabel")}</Label>
              <Input id="fax" value={fax} onChange={(e) => setFax(e.target.value)} />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="flex flex-col gap-2">
              <Label htmlFor="email">{t("emailLabel")}</Label>
              <Input id="email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
            </div>
            <div className="flex flex-col gap-2">
              <Label htmlFor="website">{t("websiteLabel")}</Label>
              <Input id="website" value={website} onChange={(e) => setWebsite(e.target.value)} />
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
