"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { Pencil, Plus, Trash2 } from "lucide-react";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { InvoiceLineDetails } from "@/components/invoice-line-details";
import { InvoiceFormDialog } from "@/components/invoice-form-dialog";
import { formatDate, formatDateTime } from "@/lib/formatDate";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { apiFetch } from "@/lib/api";

interface InvoiceListItemResponse {
  invoiceId: number;
  invoiceNumber: string;
  invoiceDate: string;
  totalAmount: number;
  customerId: number;
  customerTitle: string;
  createdDate: string;
  updatedDate: string | null;
}

interface InvoiceLineResponse {
  invoiceLineId: number;
  itemName: string;
  quantity: number;
  price: number;
}

interface InvoiceResponse {
  invoiceId: number;
  invoiceNumber: string;
  invoiceDate: string;
  totalAmount: number;
  customerId: number;
  customerTitle: string;
  createdDate: string;
  updatedDate: string | null;
  lines: InvoiceLineResponse[];
}

export default function InvoicesPage() {
  const t = useTranslations("invoices");
  const tCommon = useTranslations("common");

  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");

  const list = usePagedList<InvoiceListItemResponse>("/api/Invoices", {
    extraParams: { startDate: startDate || undefined, endDate: endDate || undefined },
  });

  const [deletingInvoice, setDeletingInvoice] = useState<InvoiceListItemResponse | null>(null);
  const [formOpen, setFormOpen] = useState(false);
  const [editingInvoice, setEditingInvoice] = useState<InvoiceResponse | null>(null);
  const [isLoadingEdit, setIsLoadingEdit] = useState(false);

  function openCreateForm() {
    setEditingInvoice(null);
    setFormOpen(true);
  }

  async function openEditForm(item: InvoiceListItemResponse) {
    setIsLoadingEdit(true);

    try {
      const full = await apiFetch<InvoiceResponse>(`/api/Invoices/${item.invoiceId}`);
      setEditingInvoice(full);
      setFormOpen(true);
    } finally {
      setIsLoadingEdit(false);
    }
  }

  const columns: PagedTableColumn<InvoiceListItemResponse>[] = [
    {
      key: "invoiceNumber",
      header: t("columnInvoiceNumber"),
      render: (i) => i.invoiceNumber,
    },
    {
      key: "customerTitle",
      header: t("columnCustomer"),
      sortKey: "customer",
      render: (i) => i.customerTitle,
    },
    {
      key: "invoiceDate",
      header: t("columnInvoiceDate"),
      sortKey: "invoicedate",
      render: (i) => formatDate(i.invoiceDate),
    },
    {
      key: "totalAmount",
      header: t("columnTotalAmount"),
      render: (i) =>
        i.totalAmount.toLocaleString(undefined, {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2,
        }),
    },
    {
      key: "createdDate",
      header: t("columnCreatedDate"),
      sortKey: "createddate",
      render: (i) => formatDateTime(i.createdDate),
    },
    {
      key: "updatedDate",
      header: t("columnUpdatedDate"),
      sortKey: "updateddate",
      render: (i) => formatDateTime(i.updatedDate),
    },
    {
      key: "actions",
      header: t("columnActions"),
      render: (i) => (
        <div className="flex items-center gap-1">
          <Button
            variant="ghost"
            size="icon-sm"
            disabled={isLoadingEdit}
            onClick={() => openEditForm(i)}
          >
            <Pencil />
          </Button>
          <Button variant="ghost" size="icon-sm" onClick={() => setDeletingInvoice(i)}>
            <Trash2 />
          </Button>
        </div>
      ),
    },
  ];

  return (
    <div className="mx-auto max-w-6xl p-6">
      <div className="mb-4 flex items-center justify-between">
        <h1 className="text-2xl font-semibold">{t("title")}</h1>
        <Button onClick={openCreateForm}>
          <Plus />
          {t("createButton")}
        </Button>
      </div>

      <div className="mb-4 flex items-end gap-4">
        <div className="flex flex-col gap-2">
          <Label htmlFor="startDate">{t("startDateLabel")}</Label>
          <Input
            id="startDate"
            type="date"
            value={startDate}
            onChange={(e) => setStartDate(e.target.value)}
            className="w-40"
          />
        </div>
        <div className="flex flex-col gap-2">
          <Label htmlFor="endDate">{t("endDateLabel")}</Label>
          <Input
            id="endDate"
            type="date"
            value={endDate}
            onChange={(e) => setEndDate(e.target.value)}
            className="w-40"
          />
        </div>
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
        getRowKey={(i) => i.invoiceId}
        renderExpandedRow={(i) => <InvoiceLineDetails invoiceId={i.invoiceId} />}
      />

      <InvoiceFormDialog
        open={formOpen}
        onOpenChange={setFormOpen}
        invoice={editingInvoice}
        onSuccess={list.refetch}
      />

      <ConfirmDialog
        open={deletingInvoice !== null}
        onOpenChange={(open) => !open && setDeletingInvoice(null)}
        title={t("deleteTitle")}
        description={
          deletingInvoice
            ? t("deleteDescription", { invoiceNumber: deletingInvoice.invoiceNumber })
            : ""
        }
        confirmLabel={tCommon("delete")}
        onConfirm={async () => {
          if (!deletingInvoice) {
            return;
          }

          await apiFetch(`/api/Invoices/${deletingInvoice.invoiceId}`, { method: "DELETE" });
          list.refetch();
        }}
      />
    </div>
  );
}