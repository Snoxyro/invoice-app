"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { Pencil, Plus, Trash2 } from "lucide-react";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { formatDateTime } from "@/lib/formatDate";
import { Button } from "@/components/ui/button";
import { FirmFormDialog } from "@/components/firm-form-dialog";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { apiFetch } from "@/lib/api";

interface FirmResponse {
  firmId: number;
  name: string;
  createdDate: string;
  updatedDate: string | null;
}

export default function AdminFirmsPage() {
  const list = usePagedList<FirmResponse>("/api/Admin/firms");
  const t = useTranslations("adminFirms");
  const tCommon = useTranslations("common");

  const [formOpen, setFormOpen] = useState(false);
  const [editingFirm, setEditingFirm] = useState<FirmResponse | null>(null);
  const [deletingFirm, setDeletingFirm] = useState<FirmResponse | null>(null);

  function openCreateForm() {
    setEditingFirm(null);
    setFormOpen(true);
  }

  function openEditForm(firm: FirmResponse) {
    setEditingFirm(firm);
    setFormOpen(true);
  }

  const columns: PagedTableColumn<FirmResponse>[] = [
    {
      key: "name",
      header: t("columnFirmName"),
      sortKey: "name",
      render: (f) => f.name,
    },
    {
      key: "createdDate",
      header: t("columnCreatedDate"),
      sortKey: "createddate",
      render: (f) => formatDateTime(f.createdDate),
    },
    {
      key: "actions",
      header: t("columnActions"),
      render: (f) => (
        <div className="flex items-center gap-1">
          <Button variant="ghost" size="icon-sm" onClick={() => openEditForm(f)}>
            <Pencil />
          </Button>
          <Button variant="ghost" size="icon-sm" onClick={() => setDeletingFirm(f)}>
            <Trash2 />
          </Button>
        </div>
      ),
    },
  ];

  return (
    <div className="mx-auto max-w-4xl p-6">
      <div className="mb-4 flex items-center justify-between">
        <h1 className="text-2xl font-semibold">{t("title")}</h1>
        <Button onClick={openCreateForm}>
          <Plus />
          {t("createButton")}
        </Button>
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
        getRowKey={(f) => f.firmId}
      />

      <FirmFormDialog
        open={formOpen}
        onOpenChange={setFormOpen}
        firm={editingFirm}
        onSuccess={list.refetch}
      />

      <ConfirmDialog
        open={deletingFirm !== null}
        onOpenChange={(open) => !open && setDeletingFirm(null)}
        title={t("deleteTitle")}
        description={deletingFirm ? t("deleteDescription", { firmName: deletingFirm.name }) : ""}
        confirmLabel={tCommon("delete")}
        onConfirm={async () => {
          if (!deletingFirm) {
            return;
          }

          await apiFetch(`/api/Admin/firms/${deletingFirm.firmId}`, { method: "DELETE" });
          list.refetch();
        }}
      />
    </div>
  );
}
