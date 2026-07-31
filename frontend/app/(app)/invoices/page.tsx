"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { Eye, Pencil, Plus, Send, Trash2 } from "lucide-react";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { NameAvatar } from "@/components/name-avatar";
import { InvoiceLineDetails } from "@/components/invoice-line-details";
import { InvoiceFormDialog } from "@/components/invoice-form-dialog";
import { InvoicePreviewDialog } from "@/components/invoice-preview-dialog";
import { formatDate, formatDateTime } from "@/lib/formatDate";
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
import { TableCell, TableRow } from "@/components/ui/table";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { PermissionGuard } from "@/components/permission-guard";
import { apiFetch } from "@/lib/api";
import { usePermissions } from "@/contexts/PermissionContext";
import type { PagedResult } from "@/lib/paging";

type InvoiceStatus = "Draft" | "Sent";

interface InvoiceListItemResponse {
  invoiceId: number;
  invoiceNumber: string | null;
  invoiceDate: string;
  subtotal: number;
  vatTotal: number;
  grandTotal: number;
  customerId: number;
  customerTitle: string;
  branchId: number | null;
  branchName: string | null;
  status: InvoiceStatus;
  createdDate: string;
  updatedDate: string | null;
}

interface InvoiceTotalsResponse {
  subtotalSum: number;
  vatTotalSum: number;
  grandTotalSum: number;
}

interface InvoiceListResponse extends PagedResult<InvoiceListItemResponse> {
  totals: InvoiceTotalsResponse;
}

interface InvoiceLineResponse {
  invoiceLineId: number;
  itemName: string;
  quantity: number;
  price: number;
  vatRateId: number;
  vatRatePercentage: number;
  subtotal: number;
  vatAmount: number;
  lineTotal: number;
}

interface InvoiceResponse {
  invoiceId: number;
  invoiceNumber: string | null;
  invoiceDate: string;
  subtotal: number;
  vatTotal: number;
  grandTotal: number;
  customerId: number;
  customerTitle: string;
  invoiceSeriesId: number;
  status: InvoiceStatus;
  createdDate: string;
  updatedDate: string | null;
  lines: InvoiceLineResponse[];
}

function formatAmount(value: number): string {
  return value.toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

export default function InvoicesPage() {
  const t = useTranslations("invoices");
  const tCommon = useTranslations("common");
  const { hasPermission } = usePermissions();

  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [statusFilter, setStatusFilter] = useState("");

  const list = usePagedList<InvoiceListItemResponse, InvoiceListResponse>("/api/Invoices", {
    extraParams: {
      startDate: startDate || undefined,
      endDate: endDate || undefined,
      status: statusFilter || undefined,
    },
  });

  const [deletingInvoice, setDeletingInvoice] = useState<InvoiceListItemResponse | null>(null);
  const [formOpen, setFormOpen] = useState(false);
  const [editingInvoice, setEditingInvoice] = useState<InvoiceResponse | null>(null);
  const [isLoadingEdit, setIsLoadingEdit] = useState(false);

  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewInvoiceId, setPreviewInvoiceId] = useState<number | null>(null);
  const [previewMode, setPreviewMode] = useState<"view" | "send">("view");

  const canCreate = hasPermission("Invoices", "Create");
  const canUpdate = hasPermission("Invoices", "Update");
  const canDelete = hasPermission("Invoices", "Delete");

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

  function openPreview(item: InvoiceListItemResponse) {
    setPreviewInvoiceId(item.invoiceId);
    setPreviewMode("view");
    setPreviewOpen(true);
  }

  function openSendConfirmation(item: InvoiceListItemResponse) {
    setPreviewInvoiceId(item.invoiceId);
    setPreviewMode("send");
    setPreviewOpen(true);
  }

  function handleStatusFilterChange(value: string | null) {
    setStatusFilter(value === "all" || value === null ? "" : value);
  }

  const columns: PagedTableColumn<InvoiceListItemResponse>[] = [
    {
      key: "invoiceNumber",
      header: t("columnInvoiceNumber"),
      render: (i) => i.invoiceNumber ?? t("draftNumberPlaceholder"),
    },
    {
      key: "customerTitle",
      header: t("columnCustomer"),
      sortKey: "customer",
      render: (i) => (
        <div className="flex items-center gap-2">
          <NameAvatar name={i.customerTitle} />
          <span>{i.customerTitle}</span>
        </div>
      ),
    },
    {
      key: "status",
      header: t("columnStatus"),
      render: (i) =>
        i.status === "Sent" ? (
          <span className="rounded bg-emerald-100 px-1.5 py-0.5 text-xs text-emerald-700 dark:bg-emerald-950 dark:text-emerald-400">
            {t("statusSent")}
          </span>
        ) : (
          <span className="rounded bg-muted px-1.5 py-0.5 text-xs text-muted-foreground">
            {t("statusDraft")}
          </span>
        ),
    },
    {
      key: "branchName",
      header: t("columnBranch"),
      sortKey: "branchname",
      render: (i) => i.branchName ?? "—",
    },
    {
      key: "invoiceDate",
      header: t("columnInvoiceDate"),
      sortKey: "invoicedate",
      render: (i) => formatDate(i.invoiceDate),
    },
    {
      key: "grandTotal",
      header: t("columnTotalAmount"),
      render: (i) => formatAmount(i.grandTotal),
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
      render: (i) => {
        const isDraft = i.status === "Draft";

        return (
          <div className="flex items-center gap-1">
            <Button variant="ghost" size="icon-sm" title={t("previewButton")} onClick={() => openPreview(i)}>
              <Eye />
            </Button>
            {canUpdate && isDraft && (
              <Button
                variant="ghost"
                size="icon-sm"
                title={t("sendButton")}
                onClick={() => openSendConfirmation(i)}
              >
                <Send />
              </Button>
            )}
            {canUpdate && isDraft && (
              <Button
                variant="ghost"
                size="icon-sm"
                disabled={isLoadingEdit}
                onClick={() => openEditForm(i)}
              >
                <Pencil />
              </Button>
            )}
            {canDelete && (
              <Button variant="ghost" size="icon-sm" onClick={() => setDeletingInvoice(i)}>
                <Trash2 />
              </Button>
            )}
          </div>
        );
      },
    },
  ];

  return (
    <PermissionGuard resource="Invoices" action="Read">
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
          getRowKey={(i) => i.invoiceId}
          renderExpandedRow={(i) => <InvoiceLineDetails invoiceId={i.invoiceId} />}
          filters={
            <>
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
              <div className="flex flex-col gap-2">
                <Label htmlFor="statusFilter">{t("statusFilterLabel")}</Label>
                <Select
                  value={statusFilter || "all"}
                  onValueChange={handleStatusFilterChange}
                >
                  <SelectTrigger id="statusFilter" className="w-36">
                    <SelectValue>
                      {(value: string | null) =>
                        value === "Draft"
                          ? t("statusDraft")
                          : value === "Sent"
                            ? t("statusSent")
                            : t("statusAll")
                      }
                    </SelectValue>
                  </SelectTrigger>
                  <SelectContent alignItemWithTrigger={false}>
                    <SelectItem value="all">{t("statusAll")}</SelectItem>
                    <SelectItem value="Draft">{t("statusDraft")}</SelectItem>
                    <SelectItem value="Sent">{t("statusSent")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </>
          }
          footer={
            <TableRow>
              <TableCell colSpan={columns.length + 1}>
                <div className="flex flex-wrap items-center justify-end gap-6 text-sm">
                  <div className="flex items-center gap-2">
                    <span className="text-muted-foreground">{t("totalsSubtotalLabel")}</span>
                    <span className="font-medium">
                      {formatAmount(list.data?.totals.subtotalSum ?? 0)}
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    <span className="text-muted-foreground">{t("totalsVatLabel")}</span>
                    <span className="font-medium">
                      {formatAmount(list.data?.totals.vatTotalSum ?? 0)}
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    <span className="text-muted-foreground">{t("totalsGrandLabel")}</span>
                    <span className="font-semibold">
                      {formatAmount(list.data?.totals.grandTotalSum ?? 0)}
                    </span>
                  </div>
                </div>
              </TableCell>
            </TableRow>
          }
        />

        <InvoiceFormDialog
          open={formOpen}
          onOpenChange={setFormOpen}
          invoice={editingInvoice}
          onSuccess={list.refetch}
        />

        <InvoicePreviewDialog
          open={previewOpen}
          onOpenChange={setPreviewOpen}
          invoiceId={previewInvoiceId}
          mode={previewMode}
          onSent={list.refetch}
        />

        <ConfirmDialog
          open={deletingInvoice !== null}
          onOpenChange={(open) => !open && setDeletingInvoice(null)}
          title={t("deleteTitle")}
          description={
            deletingInvoice
              ? t("deleteDescription", {
                  invoiceNumber: deletingInvoice.invoiceNumber ?? t("draftNumberPlaceholder"),
                })
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
    </PermissionGuard>
  );
}
