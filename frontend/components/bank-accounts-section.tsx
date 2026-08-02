"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { Pencil, Plus, Trash2 } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { BankAccountFormDialog, type BankAccountResponse } from "@/components/bank-account-form-dialog";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";

interface BankAccountsSectionProps {
  canCreate: boolean;
  canUpdate: boolean;
  canDelete: boolean;
  onDataChanged?: () => void;
}

export function BankAccountsSection({
  canCreate,
  canUpdate,
  canDelete,
  onDataChanged,
}: BankAccountsSectionProps) {
  const t = useTranslations("invoiceSettings");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const [accounts, setAccounts] = useState<BankAccountResponse[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);

  const [formOpen, setFormOpen] = useState(false);
  const [editingAccount, setEditingAccount] = useState<BankAccountResponse | null>(null);
  const [deletingAccount, setDeletingAccount] = useState<BankAccountResponse | null>(null);

  async function load() {
    setIsLoading(true);
    setLoadError(null);

    try {
      const result = await apiFetch<BankAccountResponse[]>("/api/BankAccounts");
      setAccounts(result);
    } catch (err) {
      setLoadError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setIsLoading(false);
    }
  }

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  async function refreshAfterMutation() {
    await load();
    onDataChanged?.();
  }

  function openCreateForm() {
    setEditingAccount(null);
    setFormOpen(true);
  }

  function openEditForm(account: BankAccountResponse) {
    setEditingAccount(account);
    setFormOpen(true);
  }

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle>{t("bankAccountsTitle")}</CardTitle>
            <CardDescription>{t("bankAccountsDescription")}</CardDescription>
          </div>
          {canCreate && (
            <Button onClick={openCreateForm}>
              <Plus />
              {t("bankCreateButton")}
            </Button>
          )}
        </div>
      </CardHeader>
      <CardContent>
        {isLoading && (
          <p className="py-6 text-center text-sm text-muted-foreground">{tCommon("loading")}</p>
        )}

        {!isLoading && loadError && (
          <p className="py-6 text-center text-sm text-destructive">{loadError}</p>
        )}

        {!isLoading && !loadError && accounts.length === 0 && (
          <p className="py-6 text-center text-sm text-muted-foreground">{t("bankEmptyState")}</p>
        )}

        {!isLoading && !loadError && accounts.length > 0 && (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("bankColumnName")}</TableHead>
                <TableHead>{t("bankColumnCurrency")}</TableHead>
                <TableHead>{t("bankColumnIban")}</TableHead>
                <TableHead className="text-right">{t("bankColumnActions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {accounts.map((account) => (
                <TableRow key={account.bankAccountId}>
                  <TableCell>{account.bankName}</TableCell>
                  <TableCell>{account.currency}</TableCell>
                  <TableCell className="font-mono text-xs">{account.iban}</TableCell>
                  <TableCell className="text-right">
                    <div className="flex items-center justify-end gap-1">
                      {canUpdate && (
                        <Button variant="ghost" size="icon-sm" onClick={() => openEditForm(account)}>
                          <Pencil />
                        </Button>
                      )}
                      {canDelete && (
                        <Button
                          variant="ghost"
                          size="icon-sm"
                          onClick={() => setDeletingAccount(account)}
                        >
                          <Trash2 />
                        </Button>
                      )}
                    </div>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        )}
      </CardContent>

      <BankAccountFormDialog
        open={formOpen}
        onOpenChange={setFormOpen}
        bankAccount={editingAccount}
        onSuccess={refreshAfterMutation}
      />

      <ConfirmDialog
        open={deletingAccount !== null}
        onOpenChange={(open) => !open && setDeletingAccount(null)}
        title={t("bankDeleteTitle")}
        description={deletingAccount ? t("bankDeleteDescription", { name: deletingAccount.bankName }) : ""}
        confirmLabel={tCommon("delete")}
        onConfirm={async () => {
          if (!deletingAccount) {
            return;
          }

          await apiFetch(`/api/BankAccounts/${deletingAccount.bankAccountId}`, { method: "DELETE" });
          await refreshAfterMutation();
        }}
      />
    </Card>
  );
}