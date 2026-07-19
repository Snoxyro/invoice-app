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

interface FirmResponse {
  firmId: number;
  name: string;
  createdDate: string;
  updatedDate: string | null;
}

interface FirmFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  firm: FirmResponse | null;
  onSuccess: (firm: FirmResponse) => void;
}

export function FirmFormDialog({ open, onOpenChange, firm, onSuccess }: FirmFormDialogProps) {
  const t = useTranslations("adminFirms");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const isEditMode = firm !== null;

  const [firmName, setFirmName] = useState("");
  const [firstUserName, setFirstUserName] = useState("");
  const [firstUserPassword, setFirstUserPassword] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (open) {
      setFirmName(firm?.name ?? "");
      setFirstUserName("");
      setFirstUserPassword("");
      setError(null);
    }
  }, [open, firm]);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    try {
      let result: FirmResponse;

      if (isEditMode) {
        result = await apiFetch<FirmResponse>(`/api/Admin/firms/${firm.firmId}`, {
          method: "PUT",
          body: JSON.stringify({ name: firmName }),
        });
      } else {
        result = await apiFetch<FirmResponse>("/api/Admin/firms", {
          method: "POST",
          body: JSON.stringify({ firmName, firstUserName, firstUserPassword }),
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
            <Label htmlFor="firmName">{t("firmNameLabel")}</Label>
            <Input
              id="firmName"
              value={firmName}
              onChange={(e) => setFirmName(e.target.value)}
              required
              autoFocus
            />
          </div>

          {!isEditMode && (
            <>
              <div className="flex flex-col gap-2">
                <Label htmlFor="firstUserName">{t("firstUserNameLabel")}</Label>
                <Input
                  id="firstUserName"
                  value={firstUserName}
                  onChange={(e) => setFirstUserName(e.target.value)}
                  required
                />
              </div>

              <div className="flex flex-col gap-2">
                <Label htmlFor="firstUserPassword">{t("firstUserPasswordLabel")}</Label>
                <Input
                  id="firstUserPassword"
                  type="password"
                  value={firstUserPassword}
                  onChange={(e) => setFirstUserPassword(e.target.value)}
                  required
                />
              </div>
            </>
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
