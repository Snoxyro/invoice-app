"use client";

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

const columns: PagedTableColumn<UserResponse>[] = [
  {
    key: "userName",
    header: "Kullanıcı Adı",
    sortKey: "username",
    render: (u) => u.userName,
  },
  {
    key: "role",
    header: "Rol",
    render: (u) => (u.role === "Admin" ? "Admin" : "Firma"),
  },
  {
    key: "createdDate",
    header: "Oluşturulma",
    sortKey: "createddate",
    render: (u) => formatDateTime(u.createdDate),
  },
];

export default function AdminUsersPage() {
  const list = usePagedList<UserResponse>("/api/Admin/users");

  return (
    <div className="mx-auto max-w-4xl p-6">
      <h1 className="mb-4 text-2xl font-semibold">Kullanıcılar</h1>
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