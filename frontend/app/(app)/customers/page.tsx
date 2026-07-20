"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useTranslations } from "next-intl";
import { Pencil, Plus, Receipt, Trash2 } from "lucide-react";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { NameAvatar } from "@/components/name-avatar";
import { formatDateTime } from "@/lib/formatDate";
import { Button } from "@/components/ui/button";
import { CustomerFormDialog } from "@/components/customer-form-dialog";
import { InvoiceFormDialog } from "@/components/invoice-form-dialog";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { PermissionGuard } from "@/components/permission-guard";
import { apiFetch } from "@/lib/api";
import { usePermissions } from "@/contexts/PermissionContext";

interface CustomerResponse {
  customerId: number;
  taxNumber: string;
  title: string;
  address: string;
  email: string;
  createdDate: string;
  updatedDate: string | null;
}

export default function CustomersPage() {
  const list = usePagedList<CustomerResponse>("/api/Customers");
  const t = useTranslations("customers");
  const tCommon = useTranslations("common");
  const tInvoices = useTranslations("invoices");
  const router = useRouter();
  const { hasPermission } = usePermissions();

  const [formOpen, setFormOpen] = useState(false);
  const [editingCustomer, setEditingCustomer] = useState<CustomerResponse | null>(null);
  const [deletingCustomer, setDeletingCustomer] = useState<CustomerResponse | null>(null);
  const [invoiceFormOpen, setInvoiceFormOpen] = useState(false);
  const [invoiceCustomer, setInvoiceCustomer] = useState<CustomerResponse | null>(null);

  const canCreate = hasPermission("Customers", "Create");
  const canUpdate = hasPermission("Customers", "Update");
  const canDelete = hasPermission("Customers", "Delete");
  const canCreateInvoice = hasPermission("Invoices", "Create");

  function openCreateForm() {
    setEditingCustomer(null);
    setFormOpen(true);
  }

  function openEditForm(customer: CustomerResponse) {
    setEditingCustomer(customer);
    setFormOpen(true);
  }

  function openInvoiceForm(customer: CustomerResponse) {
    setInvoiceCustomer(customer);
    setInvoiceFormOpen(true);
  }

  const columns: PagedTableColumn<CustomerResponse>[] = [
    {
      key: "title",
      header: t("columnTitle"),
      sortKey: "title",
      render: (c) => (
        <div className="flex items-center gap-2">
          <NameAvatar name={c.title} />
          <span className="font-medium">{c.title}</span>
        </div>
      ),
    },
    {
      key: "taxNumber",
      header: t("columnTaxNumber"),
      render: (c) => c.taxNumber,
    },
    {
      key: "email",
      header: t("columnEmail"),
      render: (c) => c.email,
    },
    {
      key: "createdDate",
      header: t("columnCreatedDate"),
      sortKey: "createddate",
      render: (c) => formatDateTime(c.createdDate),
    },
    {
      key: "updatedDate",
      header: t("columnUpdatedDate"),
      sortKey: "updateddate",
      render: (c) => formatDateTime(c.updatedDate),
    },
    {
      key: "actions",
      header: t("columnActions"),
      render: (c) => (
        <div className="flex items-center gap-1">
          {canCreateInvoice && (
            <Button
              variant="ghost"
              size="icon-sm"
              title={tInvoices("createButton")}
              onClick={() => openInvoiceForm(c)}
            >
              <Receipt />
            </Button>
          )}
          {canUpdate && (
            <Button variant="ghost" size="icon-sm" onClick={() => openEditForm(c)}>
              <Pencil />
            </Button>
          )}
          {canDelete && (
            <Button variant="ghost" size="icon-sm" onClick={() => setDeletingCustomer(c)}>
              <Trash2 />
            </Button>
          )}
        </div>
      ),
    },
  ];

  return (
    <PermissionGuard resource="Customers" action="Read">
      <div>
        <div className="mb-4 flex items-center justify-between">
          <h1 className="text-2xl font-semibold">{t("title")}</h1>
          {canCreate && (
            <Button onClick={openCreateForm}>
              <Plus />
              {t("createButton")}
            </Button>
          )}
        </div>

        <PagedTable
          columns={columns}
          items={list.data?.items ?? []}
          isLoading={list.isLoading}
          error={list.error}
          page={list.page}
          totalPages={list.data?.totalPages ?? 1}
          totalCount={list.data?.totalCount ?? 0}
          pageSize={list.pageSize}
          onPageChange={list.setPage}
          onPageSizeChange={list.setPageSize}
          searchInput={list.searchInput}
          onSearchChange={list.setSearchInput}
          sortBy={list.sortBy}
          sortDirection={list.sortDirection}
          onSort={list.toggleSort}
          getRowKey={(c) => c.customerId}
        />

        <CustomerFormDialog
          open={formOpen}
          onOpenChange={setFormOpen}
          customer={editingCustomer}
          onSuccess={list.refetch}
        />

        <InvoiceFormDialog
          open={invoiceFormOpen}
          onOpenChange={setInvoiceFormOpen}
          invoice={null}
          lockedCustomer={invoiceCustomer}
          onSuccess={() => router.push("/invoices")}
        />

        <ConfirmDialog
          open={deletingCustomer !== null}
          onOpenChange={(open) => !open && setDeletingCustomer(null)}
          title={t("deleteTitle")}
          description={
            deletingCustomer ? t("deleteDescription", { title: deletingCustomer.title }) : ""
          }
          confirmLabel={tCommon("delete")}
          onConfirm={async () => {
            if (!deletingCustomer) {
              return;
            }

            await apiFetch(`/api/Customers/${deletingCustomer.customerId}`, { method: "DELETE" });
            list.refetch();
          }}
        />
      </div>
    </PermissionGuard>
  );
}