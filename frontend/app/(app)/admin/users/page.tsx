"use client";

import { useTranslations } from "next-intl";
import { usePagedList } from "@/hooks/usePagedList";
import { PagedTable, type PagedTableColumn } from "@/components/paged-table";
import { formatDateTime } from "@/lib/formatDate";

interface UserResponse {
  userId: number;
  userName: string;
  role: "Admin" | "Firm";
  createdDate: string;
  updatedDate: string | null;
}

export default function AdminUsersPage() {
  const list = usePagedList<UserResponse>("/api/Admin/users");
  const t = useTranslations("adminUsers");
  const tRoles = useTranslations("roles");

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
  ];

  return (
    <div className="mx-auto max-w-4xl p-6">
      <h1 className="mb-4 text-2xl font-semibold">{t("title")}</h1>
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
    </div>
  );
}