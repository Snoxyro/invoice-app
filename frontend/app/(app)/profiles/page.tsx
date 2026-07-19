"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { Pencil, Plus, Trash2 } from "lucide-react";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { formatDateTime } from "@/lib/formatDate";
import { Button } from "@/components/ui/button";
import { ProfileFormDialog } from "@/components/profile-form-dialog";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { PermissionGuard } from "@/components/permission-guard";
import { apiFetch } from "@/lib/api";
import { usePermissions } from "@/contexts/PermissionContext";

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

export default function ProfilesPage() {
  const list = usePagedList<ProfileResponse>("/api/Profiles");
  const t = useTranslations("profiles");
  const tCommon = useTranslations("common");
  const { hasPermission, profileId: ownProfileId } = usePermissions();

  const [formOpen, setFormOpen] = useState(false);
  const [editingProfile, setEditingProfile] = useState<ProfileResponse | null>(null);
  const [deletingProfile, setDeletingProfile] = useState<ProfileResponse | null>(null);

  const canCreate = hasPermission("Profiles", "Create");
  const canUpdate = hasPermission("Profiles", "Update");
  const canDelete = hasPermission("Profiles", "Delete");

  function openCreateForm() {
    setEditingProfile(null);
    setFormOpen(true);
  }

  function openEditForm(profile: ProfileResponse) {
    setEditingProfile(profile);
    setFormOpen(true);
  }

  const columns: PagedTableColumn<ProfileResponse>[] = [
    {
      key: "name",
      header: t("columnName"),
      sortKey: "name",
      render: (p) => (
        <span className="flex items-center gap-2">
          {p.name}
          {p.isSystem && (
            <span className="rounded bg-muted px-1.5 py-0.5 text-xs text-muted-foreground">
              {t("systemBadge")}
            </span>
          )}
        </span>
      ),
    },
    {
      key: "createdDate",
      header: t("columnCreatedDate"),
      sortKey: "createddate",
      render: (p) => formatDateTime(p.createdDate),
    },
    {
      key: "actions",
      header: t("columnActions"),
      render: (p) => {
        const isOwnProfile = p.profileId === ownProfileId;
        const canEditThis = canUpdate && !p.isSystem && !isOwnProfile;
        const canDeleteThis = canDelete && !p.isSystem && !isOwnProfile;

        return (
          <div className="flex items-center gap-1">
            {canEditThis && (
              <Button variant="ghost" size="icon-sm" onClick={() => openEditForm(p)}>
                <Pencil />
              </Button>
            )}
            {canDeleteThis && (
              <Button variant="ghost" size="icon-sm" onClick={() => setDeletingProfile(p)}>
                <Trash2 />
              </Button>
            )}
          </div>
        );
      },
    },
  ];

  return (
    <PermissionGuard resource="Profiles" action="Read">
      <div className="mx-auto max-w-4xl p-6">
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
          getRowKey={(p) => p.profileId}
        />

        <ProfileFormDialog
          open={formOpen}
          onOpenChange={setFormOpen}
          profile={editingProfile}
          onSuccess={list.refetch}
        />

        <ConfirmDialog
          open={deletingProfile !== null}
          onOpenChange={(open) => !open && setDeletingProfile(null)}
          title={t("deleteTitle")}
          description={deletingProfile ? t("deleteDescription", { name: deletingProfile.name }) : ""}
          confirmLabel={tCommon("delete")}
          onConfirm={async () => {
            if (!deletingProfile) {
              return;
            }

            await apiFetch(`/api/Profiles/${deletingProfile.profileId}`, { method: "DELETE" });
            list.refetch();
          }}
        />
      </div>
    </PermissionGuard>
  );
}
