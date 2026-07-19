"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { Pencil, Plus, Trash2 } from "lucide-react";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { formatDateTime } from "@/lib/formatDate";
import { Button } from "@/components/ui/button";
import { UserFormDialog } from "@/components/user-form-dialog";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { PermissionGuard } from "@/components/permission-guard";
import { apiFetch } from "@/lib/api";
import { usePermissions } from "@/contexts/PermissionContext";
import { useAuth } from "@/contexts/AuthContext";

interface UserResponse {
  userId: number;
  userName: string;
  profileId: number | null;
  profileName: string | null;
  createdDate: string;
  updatedDate: string | null;
}

export default function UsersPage() {
  const list = usePagedList<UserResponse>("/api/Users");
  const t = useTranslations("users");
  const tCommon = useTranslations("common");
  const { hasPermission } = usePermissions();
  const { user: currentUser } = useAuth();

  const [formOpen, setFormOpen] = useState(false);
  const [editingUser, setEditingUser] = useState<UserResponse | null>(null);
  const [deletingUser, setDeletingUser] = useState<UserResponse | null>(null);

  const canCreate = hasPermission("Users", "Create");
  const canUpdate = hasPermission("Users", "Update");
  const canDelete = hasPermission("Users", "Delete");

  function openCreateForm() {
    setEditingUser(null);
    setFormOpen(true);
  }

  function openEditForm(user: UserResponse) {
    setEditingUser(user);
    setFormOpen(true);
  }

  const columns: PagedTableColumn<UserResponse>[] = [
    {
      key: "userName",
      header: t("columnUsername"),
      sortKey: "username",
      render: (u) => u.userName,
    },
    {
      key: "profileName",
      header: t("columnProfile"),
      sortKey: "profilename",
      render: (u) => u.profileName ?? "—",
    },
    {
      key: "createdDate",
      header: t("columnCreatedDate"),
      sortKey: "createddate",
      render: (u) => formatDateTime(u.createdDate),
    },
    {
      key: "actions",
      header: t("columnActions"),
      render: (u) => {
        const isSelf = u.userId === currentUser?.userId;
        const canEditThis = canUpdate && !isSelf;
        const canDeleteThis = canDelete && !isSelf;

        return (
          <div className="flex items-center gap-1">
            {canEditThis && (
              <Button variant="ghost" size="icon-sm" onClick={() => openEditForm(u)}>
                <Pencil />
              </Button>
            )}
            {canDeleteThis && (
              <Button variant="ghost" size="icon-sm" onClick={() => setDeletingUser(u)}>
                <Trash2 />
              </Button>
            )}
          </div>
        );
      },
    },
  ];

  return (
    <PermissionGuard resource="Users" action="Read">
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
          getRowKey={(u) => u.userId}
        />

        <UserFormDialog
          open={formOpen}
          onOpenChange={setFormOpen}
          user={editingUser}
          onSuccess={list.refetch}
        />

        <ConfirmDialog
          open={deletingUser !== null}
          onOpenChange={(open) => !open && setDeletingUser(null)}
          title={t("deleteTitle")}
          description={deletingUser ? t("deleteDescription", { userName: deletingUser.userName }) : ""}
          confirmLabel={tCommon("delete")}
          onConfirm={async () => {
            if (!deletingUser) {
              return;
            }

            await apiFetch(`/api/Users/${deletingUser.userId}`, { method: "DELETE" });
            list.refetch();
          }}
        />
      </div>
    </PermissionGuard>
  );
}
