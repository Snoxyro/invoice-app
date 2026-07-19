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
import { Checkbox } from "@/components/ui/checkbox";
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";
import { usePermissions } from "@/contexts/PermissionContext";
import type { PermissionActionType, PermissionResource } from "@/lib/permissions";

interface ProfileResponse {
  profileId: number;
  name: string;
  isSystem: boolean;
  minInvoiceAmount: number | null;
  maxInvoiceAmount: number | null;
  permissionIds: number[];
  vatRateIds: number[];
  createdDate: string;
  updatedDate: string | null;
}

interface PermissionCatalogItemResponse {
  permissionId: number;
  resource: PermissionResource;
  action: PermissionActionType;
}

interface VatRateResponse {
  vatRateId: number;
  rate: number;
}

interface ProfileFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  profile: ProfileResponse | null;
  onSuccess: (profile: ProfileResponse) => void;
}

const RESOURCE_ORDER: PermissionResource[] = ["Users", "Profiles", "Customers", "Invoices"];
const ACTION_ORDER: PermissionActionType[] = ["Create", "Read", "Update", "Delete"];

export function ProfileFormDialog({ open, onOpenChange, profile, onSuccess }: ProfileFormDialogProps) {
  const t = useTranslations("profiles");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");
  const {
    hasPermission,
    vatRates: ownVatRates,
    minInvoiceAmount: ownMin,
    maxInvoiceAmount: ownMax,
  } = usePermissions();

  const isEditMode = profile !== null;

  const [name, setName] = useState("");
  const [permissionIds, setPermissionIds] = useState<Set<number>>(new Set());
  const [vatRateIds, setVatRateIds] = useState<Set<number>>(new Set());
  const [minInvoiceAmount, setMinInvoiceAmount] = useState("");
  const [maxInvoiceAmount, setMaxInvoiceAmount] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [permissionCatalog, setPermissionCatalog] = useState<PermissionCatalogItemResponse[]>([]);
  const [vatRateCatalog, setVatRateCatalog] = useState<VatRateResponse[]>([]);
  const [isCatalogLoading, setIsCatalogLoading] = useState(true);

  useEffect(() => {
    if (!open) {
      return;
    }

    setName(profile?.name ?? "");
    setPermissionIds(new Set(profile?.permissionIds ?? []));
    setVatRateIds(new Set(profile?.vatRateIds ?? []));
    setMinInvoiceAmount(profile?.minInvoiceAmount != null ? String(profile.minInvoiceAmount) : "");
    setMaxInvoiceAmount(profile?.maxInvoiceAmount != null ? String(profile.maxInvoiceAmount) : "");
    setError(null);
  }, [open, profile]);

  useEffect(() => {
    if (!open) {
      return;
    }

    let isCancelled = false;

    async function loadCatalogs() {
      setIsCatalogLoading(true);

      try {
        const [permissions, vatRates] = await Promise.all([
          apiFetch<PermissionCatalogItemResponse[]>("/api/Profiles/permission-catalog"),
          apiFetch<VatRateResponse[]>("/api/Profiles/vat-rate-catalog"),
        ]);

        if (!isCancelled) {
          setPermissionCatalog(permissions);
          setVatRateCatalog(vatRates);
        }
      } finally {
        if (!isCancelled) {
          setIsCatalogLoading(false);
        }
      }
    }

    loadCatalogs();

    return () => {
      isCancelled = true;
    };
  }, [open]);

  const catalogIndex: Partial<Record<PermissionResource, Partial<Record<PermissionActionType, number>>>> = {};

  for (const item of permissionCatalog) {
    catalogIndex[item.resource] = catalogIndex[item.resource] ?? {};
    catalogIndex[item.resource]![item.action] = item.permissionId;
  }

  const invoicesCreateId = catalogIndex.Invoices?.Create;
  const invoicesUpdateId = catalogIndex.Invoices?.Update;
  const canEditInvoicesInThisProfile =
    (invoicesCreateId != null && permissionIds.has(invoicesCreateId)) ||
    (invoicesUpdateId != null && permissionIds.has(invoicesUpdateId));

  function togglePermission(resource: PermissionResource, action: PermissionActionType) {
    const permissionId = catalogIndex[resource]?.[action];

    if (!permissionId) {
      return;
    }

    setPermissionIds((prev) => {
      const next = new Set(prev);
      const isChecked = next.has(permissionId);

      if (isChecked) {
        next.delete(permissionId);

        if (action === "Read") {
          for (const mutatingAction of ["Create", "Update", "Delete"] as const) {
            const mutatingId = catalogIndex[resource]?.[mutatingAction];

            if (mutatingId) {
              next.delete(mutatingId);
            }
          }
        }
      } else {
        next.add(permissionId);

        if (action !== "Read") {
          const readId = catalogIndex[resource]?.Read;

          if (readId) {
            next.add(readId);
          }
        }
      }

      return next;
    });
  }

  function toggleVatRate(vatRateId: number) {
    setVatRateIds((prev) => {
      const next = new Set(prev);

      if (next.has(vatRateId)) {
        next.delete(vatRateId);
      } else {
        next.add(vatRateId);
      }

      return next;
    });
  }

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const payload = {
      name,
      permissionIds: Array.from(permissionIds),
      vatRateIds: Array.from(vatRateIds),
      minInvoiceAmount: minInvoiceAmount === "" ? null : Number(minInvoiceAmount),
      maxInvoiceAmount: maxInvoiceAmount === "" ? null : Number(maxInvoiceAmount),
    };

    try {
      let result: ProfileResponse;

      if (isEditMode) {
        result = await apiFetch<ProfileResponse>(`/api/Profiles/${profile.profileId}`, {
          method: "PUT",
          body: JSON.stringify(payload),
        });
      } else {
        result = await apiFetch<ProfileResponse>("/api/Profiles", {
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

  const resourceLabels: Record<PermissionResource, string> = {
    Users: t("resourceUsers"),
    Profiles: t("resourceProfiles"),
    Customers: t("resourceCustomers"),
    Invoices: t("resourceInvoices"),
  };

  const actionLabels: Record<PermissionActionType, string> = {
    Create: t("actionCreate"),
    Read: t("actionRead"),
    Update: t("actionUpdate"),
    Delete: t("actionDelete"),
  };

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogContent className="sm:max-w-2xl">
        <DialogHeader>
          <DialogTitle>{isEditMode ? t("editTitle") : t("createTitle")}</DialogTitle>
          <DialogDescription>
            {isEditMode ? t("editDescription") : t("createDescription")}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="flex max-h-[70vh] flex-col gap-4 overflow-y-auto px-4">
          <div className="flex flex-col gap-2">
            <Label htmlFor="profileName">{t("nameLabel")}</Label>
            <Input
              id="profileName"
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
              autoFocus
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label>{t("permissionsLabel")}</Label>

            {isCatalogLoading ? (
              <p className="text-sm text-muted-foreground">{tCommon("processing")}</p>
            ) : (
              <div className="rounded-lg border">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b">
                      <th className="p-2 text-left font-medium" />
                      {ACTION_ORDER.map((action) => (
                        <th key={action} className="p-2 text-center font-medium">
                          {actionLabels[action]}
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {RESOURCE_ORDER.map((resource) => (
                      <tr key={resource} className="border-b last:border-0">
                        <td className="p-2 font-medium">{resourceLabels[resource]}</td>
                        {ACTION_ORDER.map((action) => {
                          const permissionId = catalogIndex[resource]?.[action];
                          const isCallerAllowed = hasPermission(resource, action);

                          return (
                            <td key={action} className="p-2 text-center">
                              <Checkbox
                                checked={permissionId ? permissionIds.has(permissionId) : false}
                                onCheckedChange={() => togglePermission(resource, action)}
                                disabled={!permissionId || !isCallerAllowed}
                              />
                            </td>
                          );
                        })}
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>

          <div className="flex flex-col gap-4 rounded-lg border p-3">
            <div className="flex items-center justify-between gap-4">
              <Label>{t("invoiceSettingsTitle")}</Label>
              {!canEditInvoicesInThisProfile && (
                <p className="text-xs text-muted-foreground">{t("invoiceSettingsDisabledHint")}</p>
              )}
            </div>

            <div className="flex flex-col gap-2">
              <Label className="text-sm font-normal text-muted-foreground">{t("vatRatesLabel")}</Label>

              {isCatalogLoading ? (
                <p className="text-sm text-muted-foreground">{tCommon("processing")}</p>
              ) : (
                <div className="flex flex-wrap gap-4">
                  {vatRateCatalog.map((vatRate) => {
                    const isCallerAllowed = ownVatRates.some((v) => v.vatRateId === vatRate.vatRateId);
                    const isFieldEnabled = isCallerAllowed && canEditInvoicesInThisProfile;

                    return (
                      <div key={vatRate.vatRateId} className="flex items-center gap-2">
                        <Checkbox
                          id={`vat-${vatRate.vatRateId}`}
                          checked={vatRateIds.has(vatRate.vatRateId)}
                          onCheckedChange={() => toggleVatRate(vatRate.vatRateId)}
                          disabled={!isFieldEnabled}
                        />
                        <Label htmlFor={`vat-${vatRate.vatRateId}`} className="cursor-pointer font-normal">
                          %{vatRate.rate}
                        </Label>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="flex flex-col gap-2">
                <Label htmlFor="minInvoiceAmount" className="text-sm font-normal text-muted-foreground">
                  {t("minInvoiceAmountLabel")}
                </Label>
                <Input
                  id="minInvoiceAmount"
                  type="number"
                  step="0.01"
                  min="0"
                  placeholder={t("unlimitedHint")}
                  value={minInvoiceAmount}
                  onChange={(e) => setMinInvoiceAmount(e.target.value)}
                  disabled={!canEditInvoicesInThisProfile}
                />
              </div>
              <div className="flex flex-col gap-2">
                <Label htmlFor="maxInvoiceAmount" className="text-sm font-normal text-muted-foreground">
                  {t("maxInvoiceAmountLabel")}
                </Label>
                <Input
                  id="maxInvoiceAmount"
                  type="number"
                  step="0.01"
                  min="0"
                  placeholder={t("unlimitedHint")}
                  value={maxInvoiceAmount}
                  onChange={(e) => setMaxInvoiceAmount(e.target.value)}
                  disabled={!canEditInvoicesInThisProfile}
                />
              </div>
            </div>

            {(ownMin !== null || ownMax !== null) && (
              <p className="text-xs text-muted-foreground">
                {t("ownRangeHint", { min: ownMin ?? "—", max: ownMax ?? "—" })}
              </p>
            )}
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
            <Button type="submit" disabled={isSubmitting || isCatalogLoading}>
              {isSubmitting ? tCommon("processing") : tCommon("save")}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
