"use client";

import { useEffect, useState, type FormEvent } from "react";
import { useTranslations } from "next-intl";
import { Plus } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";
import { usePermissions } from "@/contexts/PermissionContext";

interface InvoiceSeriesResponse {
  invoiceSeriesId: number;
  branchId: number;
  prefix: string;
  lastUsedYear: number;
  nextNumber: number;
  isActive: boolean;
}

interface BranchSeriesDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  branchId: number | null;
  branchName: string;
}

export function BranchSeriesDialog({
  open,
  onOpenChange,
  branchId,
  branchName,
}: BranchSeriesDialogProps) {
  const t = useTranslations("branches");
  const tTable = useTranslations("table");
  const tErrors = useTranslations("errors");
  const { hasPermission } = usePermissions();

  const canUpdate = hasPermission("Branches", "Update");

  const [series, setSeries] = useState<InvoiceSeriesResponse[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [newPrefix, setNewPrefix] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [togglingId, setTogglingId] = useState<number | null>(null);

  async function load() {
    if (branchId === null) {
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const result = await apiFetch<InvoiceSeriesResponse[]>(`/api/Branches/${branchId}/series`);
      setSeries(result);
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, t("seriesLoadError")));
    } finally {
      setIsLoading(false);
    }
  }

  useEffect(() => {
    if (open && branchId !== null) {
      setNewPrefix("");
      load();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, branchId]);

  async function handleAddSeries(event: FormEvent) {
    event.preventDefault();

    if (branchId === null) {
      return;
    }

    setIsSubmitting(true);
    setError(null);

    try {
      await apiFetch<InvoiceSeriesResponse>(`/api/Branches/${branchId}/series`, {
        method: "POST",
        body: JSON.stringify({ prefix: newPrefix.toUpperCase() }),
      });

      setNewPrefix("");
      await load();
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setIsSubmitting(false);
    }
  }

  async function handleToggleActive(item: InvoiceSeriesResponse) {
    if (branchId === null) {
      return;
    }

    setTogglingId(item.invoiceSeriesId);
    setError(null);

    try {
      await apiFetch<InvoiceSeriesResponse>(
        `/api/Branches/${branchId}/series/${item.invoiceSeriesId}`,
        {
          method: "PUT",
          body: JSON.stringify({ isActive: !item.isActive }),
        }
      );

      await load();
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setTogglingId(null);
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle>{t("seriesDialogTitle", { branchName })}</DialogTitle>
          <DialogDescription>{t("seriesDialogDescription")}</DialogDescription>
        </DialogHeader>

        <div className="flex flex-col gap-4 px-4">
          <div className="overflow-hidden rounded-lg border">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("seriesColumnPrefix")}</TableHead>
                  <TableHead>{t("seriesColumnYear")}</TableHead>
                  <TableHead>{t("seriesColumnNextNumber")}</TableHead>
                  <TableHead>{t("seriesColumnStatus")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {isLoading && (
                  <TableRow>
                    <TableCell colSpan={4} className="text-center text-muted-foreground">
                      {tTable("loading")}
                    </TableCell>
                  </TableRow>
                )}
                {!isLoading && !error && series.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={4} className="text-center text-muted-foreground">
                      {t("noSeriesFound")}
                    </TableCell>
                  </TableRow>
                )}
                {!isLoading &&
                  series.map((item) => (
                    <TableRow key={item.invoiceSeriesId}>
                      <TableCell className="font-medium">{item.prefix}</TableCell>
                      <TableCell>{item.lastUsedYear}</TableCell>
                      <TableCell>{item.nextNumber}</TableCell>
                      <TableCell>
                        <Button
                          type="button"
                          variant={item.isActive ? "secondary" : "outline"}
                          size="sm"
                          disabled={!canUpdate || togglingId === item.invoiceSeriesId}
                          onClick={() => handleToggleActive(item)}
                        >
                          {item.isActive ? t("seriesActiveLabel") : t("seriesInactiveLabel")}
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))}
              </TableBody>
            </Table>
          </div>

          {canUpdate && (
            <form onSubmit={handleAddSeries} className="flex items-end gap-2">
              <div className="flex flex-1 flex-col gap-2">
                <Label htmlFor="newSeriesPrefix">{t("newSeriesPrefixLabel")}</Label>
                <Input
                  id="newSeriesPrefix"
                  value={newPrefix}
                  onChange={(e) => setNewPrefix(e.target.value.toUpperCase().slice(0, 3))}
                  maxLength={3}
                  placeholder={t("newSeriesPrefixHint")}
                  required
                />
              </div>
              <Button type="submit" disabled={isSubmitting || newPrefix.length !== 3}>
                <Plus />
                {t("addSeriesButton")}
              </Button>
            </form>
          )}

          {error && <p className="text-sm text-destructive">{error}</p>}
        </div>
      </DialogContent>
    </Dialog>
  );
}
