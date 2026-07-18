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
import { apiFetch } from "@/lib/api";
import { useAuth } from "@/contexts/AuthContext";

type UserRole = "Admin" | "Firm";

interface UserResponse {
  userId: number;
  userName: string;
  role: UserRole;
  createdDate: string;
  updatedDate: string | null;
}

export default function AdminUsersPage() {
  const list = usePagedList<UserResponse>("/api/Admin/users");
  const t = useTranslations("adminUsers");
  const tRoles = useTranslations("roles");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");
  const { user: currentUser } = useAuth();

  const [formOpen, setFormOpen] = useState(false);
  const [editingUser, setEditingUser] = useState<UserResponse | null>(null);
  const [deletingUser, setDeletingUser] = useState<UserResponse | null>(null);

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
      key: "role",
      header: t("columnRole"),
      render: (u) => (u.role === "Admin" ? tRoles("admin") : tRoles("firm")),
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

        return (
          <div className="flex items-center gap-1">
            <Button variant="ghost" size="icon-sm" onClick={() => openEditForm(u)}>
              <Pencil />
            </Button>
            <Button
              variant="ghost"
              size="icon-sm"
              disabled={isSelf}
              title={isSelf ? tErrors("CANNOT_DELETE_OWN_ACCOUNT") : undefined}
              onClick={() => setDeletingUser(u)}
            >
              <Trash2 />
            </Button>
          </div>
        );
      },
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

          await apiFetch(`/api/Admin/users/${deletingUser.userId}`, { method: "DELETE" });
          list.refetch();
        }}
      />
    </div>
  );
}