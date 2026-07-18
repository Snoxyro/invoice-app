"use client";

import { useCallback, useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";
import type { PagedResult, SortDirection } from "@/lib/paging";

interface UsePagedListOptions {
  pageSize?: number;
  sortBy?: string;
  sortDirection?: SortDirection;
}

export function usePagedList<T>(endpoint: string, options: UsePagedListOptions = {}) {
  const t = useTranslations("table");
  const tErrors = useTranslations("errors");
  const [page, setPage] = useState(1);
  const [pageSize, setPageSizeState] = useState(options.pageSize ?? 10);
  const [searchInput, setSearchInput] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const [sortBy, setSortBy] = useState(options.sortBy ?? "");
  const [sortDirection, setSortDirection] = useState<SortDirection>(
    options.sortDirection ?? "Ascending"
  );
  const [data, setData] = useState<PagedResult<T> | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const timeout = setTimeout(() => {
      setSearchTerm(searchInput);
      setPage(1);
    }, 400);

    return () => clearTimeout(timeout);
  }, [searchInput]);

  const load = useCallback(async () => {
    setIsLoading(true);
    setError(null);

    const query = new URLSearchParams();
    query.set("page", String(page));
    query.set("pageSize", String(pageSize));

    if (searchTerm) {
      query.set("searchTerm", searchTerm);
    }

    if (sortBy) {
      query.set("sortBy", sortBy);
    }

    query.set("sortDirection", sortDirection);

    try {
      const result = await apiFetch<PagedResult<T>>(`${endpoint}?${query.toString()}`);
      setData(result);
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, t("loadError")));
    } finally {
      setIsLoading(false);
    }
  }, [endpoint, page, pageSize, searchTerm, sortBy, sortDirection, t, tErrors]);

  useEffect(() => {
    load();
  }, [load]);

  function toggleSort(key: string) {
    if (sortBy === key) {
      setSortDirection((prev) => (prev === "Ascending" ? "Descending" : "Ascending"));
    } else {
      setSortBy(key);
      setSortDirection("Ascending");
    }
    setPage(1);
  }

  function setPageSize(value: number) {
    setPageSizeState(value);
    setPage(1);
  }

  return {
    data,
    isLoading,
    error,
    page,
    setPage,
    pageSize,
    setPageSize,
    searchInput,
    setSearchInput,
    sortBy,
    sortDirection,
    toggleSort,
    refetch: load,
  };
}