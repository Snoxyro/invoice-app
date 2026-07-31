"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { Hash, Pencil, Plus, Trash2 } from "lucide-react";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { formatDateTime } from "@/lib/formatDate";
import { Button } from "@/components/ui/button";
import { BranchFormDialog } from "@/components/branch-form-dialog";
import { BranchSeriesDialog } from "@/components/branch-series-dialog";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { PermissionGuard } from "@/components/permission-guard";
import { apiFetch } from "@/lib/api";
import { usePermissions } from "@/contexts/PermissionContext";

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

export default function BranchesPage() {
  const list = usePagedList<BranchResponse>("/api/Branches");
  const t = useTranslations("branches");
  const tCommon = useTranslations("common");
  const { hasPermission } = usePermissions();

  const [formOpen, setFormOpen] = useState(false);
  const [editingBranch, setEditingBranch] = useState<BranchResponse | null>(null);
  const [deletingBranch, setDeletingBranch] = useState<BranchResponse | null>(null);
  const [seriesBranch, setSeriesBranch] = useState<BranchResponse | null>(null);

  const canCreate = hasPermission("Branches", "Create");
  const canUpdate = hasPermission("Branches", "Update");
  const canDelete = hasPermission("Branches", "Delete");

  function openCreateForm() {
    setEditingBranch(null);
    setFormOpen(true);
  }

  function openEditForm(branch: BranchResponse) {
    setEditingBranch(branch);
    setFormOpen(true);
  }

  const columns: PagedTableColumn<BranchResponse>[] = [
    {
      key: "name",
      header: t("columnName"),
      sortKey: "name",
      render: (b) => (
        <span className="flex items-center gap-2">
          {b.name}
          {b.isHeadquarters && (
            <span className="rounded bg-muted px-1.5 py-0.5 text-xs text-muted-foreground">
              {t("headquartersBadge")}
            </span>
          )}
        </span>
      ),
    },
    {
      key: "city",
      header: t("columnCity"),
      render: (b) => b.city ?? "—",
    },
    {
      key: "createdDate",
      header: t("columnCreatedDate"),
      sortKey: "createddate",
      render: (b) => formatDateTime(b.createdDate),
    },
    {
      key: "actions",
      header: t("columnActions"),
      render: (b) => (
        <div className="flex items-center gap-1">
          <Button
            variant="ghost"
            size="icon-sm"
            title={t("manageSeriesButton")}
            onClick={() => setSeriesBranch(b)}
          >
            <Hash />
          </Button>
          {canUpdate && (
            <Button variant="ghost" size="icon-sm" onClick={() => openEditForm(b)}>
              <Pencil />
            </Button>
          )}
          {canDelete && !b.isHeadquarters && (
            <Button variant="ghost" size="icon-sm" onClick={() => setDeletingBranch(b)}>
              <Trash2 />
            </Button>
          )}
        </div>
      ),
    },
  ];

  return (
    <PermissionGuard resource="Branches" action="Read">
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
          getRowKey={(b) => b.branchId}
        />

        <BranchFormDialog
          open={formOpen}
          onOpenChange={setFormOpen}
          branch={editingBranch}
          onSuccess={list.refetch}
        />

        <BranchSeriesDialog
          open={seriesBranch !== null}
          onOpenChange={(open) => !open && setSeriesBranch(null)}
          branchId={seriesBranch?.branchId ?? null}
          branchName={seriesBranch?.name ?? ""}
        />

        <ConfirmDialog
          open={deletingBranch !== null}
          onOpenChange={(open) => !open && setDeletingBranch(null)}
          title={t("deleteTitle")}
          description={deletingBranch ? t("deleteDescription", { name: deletingBranch.name }) : ""}
          confirmLabel={tCommon("delete")}
          onConfirm={async () => {
            if (!deletingBranch) {
              return;
            }

            await apiFetch(`/api/Branches/${deletingBranch.branchId}`, { method: "DELETE" });
            list.refetch();
          }}
        />
      </div>
    </PermissionGuard>
  );
}
