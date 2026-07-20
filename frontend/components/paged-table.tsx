"use client";

import { useState, type ReactNode } from "react";
import { useTranslations } from "next-intl";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { ArrowDown, ArrowUp, ChevronLeft, ChevronRight, Search } from "lucide-react";
import type { SortDirection } from "@/lib/paging";

export interface PagedTableColumn<T> {
  key: string;
  header: string;
  sortKey?: string;
  render: (item: T) => ReactNode;
}

interface PagedTableProps<T> {
  columns: PagedTableColumn<T>[];
  items: T[];
  isLoading: boolean;
  error: string | null;
  page: number;
  totalPages: number;
  totalCount: number;
  pageSize: number;
  onPageChange: (page: number) => void;
  onPageSizeChange: (pageSize: number) => void;
  searchInput: string;
  onSearchChange: (value: string) => void;
  sortBy: string;
  sortDirection: SortDirection;
  onSort: (key: string) => void;
  getRowKey: (item: T) => string | number;
  renderExpandedRow?: (item: T) => ReactNode;
  emptyMessage?: string;
  filters?: ReactNode;
}

export function PagedTable<T>({
  columns,
  items,
  isLoading,
  error,
  page,
  totalPages,
  totalCount,
  pageSize,
  onPageChange,
  onPageSizeChange,
  searchInput,
  onSearchChange,
  sortBy,
  sortDirection,
  onSort,
  getRowKey,
  renderExpandedRow,
  emptyMessage,
  filters,
}: PagedTableProps<T>) {
  const t = useTranslations("table");
  const columnCount = columns.length + (renderExpandedRow ? 1 : 0);
  const resolvedEmptyMessage = emptyMessage ?? t("empty");

  return (
    <div className="flex flex-col gap-4">
      <Card>
        <CardContent className="flex flex-wrap items-end gap-4">
          <div className="relative min-w-[200px] flex-1">
            <Search className="pointer-events-none absolute top-1/2 left-2.5 size-4 -translate-y-1/2 text-muted-foreground" />
            <Input
              placeholder={t("searchPlaceholder")}
              value={searchInput}
              onChange={(e) => onSearchChange(e.target.value)}
              className="pl-8"
            />
          </div>
          {filters}
          <Select
            value={String(pageSize)}
            onValueChange={(value) => onPageSizeChange(Number(value))}
          >
            <SelectTrigger className="w-24">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="10">10</SelectItem>
              <SelectItem value="20">20</SelectItem>
              <SelectItem value="50">50</SelectItem>
            </SelectContent>
          </Select>
        </CardContent>
      </Card>

      <div className="rounded-lg border">
        <Table>
          <TableHeader>
            <TableRow>
              {columns.map((column) => (
                <TableHead key={column.key}>
                  {column.sortKey ? (
                    <button
                      type="button"
                      onClick={() => onSort(column.sortKey!)}
                      className="flex items-center gap-1"
                    >
                      {column.header}
                      {sortBy === column.sortKey &&
                        (sortDirection === "Ascending" ? (
                          <ArrowUp className="size-3.5" />
                        ) : (
                          <ArrowDown className="size-3.5" />
                        ))}
                    </button>
                  ) : (
                    column.header
                  )}
                </TableHead>
              ))}
              {renderExpandedRow && <TableHead />}
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading && (
              <TableRow>
                <TableCell colSpan={columnCount} className="text-center text-muted-foreground">
                  {t("loading")}
                </TableCell>
              </TableRow>
            )}
            {!isLoading && error && (
              <TableRow>
                <TableCell colSpan={columnCount} className="text-center text-destructive">
                  {error}
                </TableCell>
              </TableRow>
            )}
            {!isLoading && !error && items.length === 0 && (
              <TableRow>
                <TableCell colSpan={columnCount} className="text-center text-muted-foreground">
                  {resolvedEmptyMessage}
                </TableCell>
              </TableRow>
            )}
            {!isLoading &&
              !error &&
              items.map((item) => (
                <PagedTableRow
                  key={getRowKey(item)}
                  item={item}
                  columns={columns}
                  renderExpandedRow={renderExpandedRow}
                />
              ))}
          </TableBody>
        </Table>
      </div>

      <div className="flex items-center justify-between text-sm text-muted-foreground">
        <span>{t("totalRecords", { count: totalCount })}</span>
        <div className="flex items-center gap-2">
          <Button
            variant="outline"
            size="icon-sm"
            disabled={page <= 1}
            onClick={() => onPageChange(page - 1)}
          >
            <ChevronLeft className="size-4" />
          </Button>
          <span>{t("pageOf", { page, totalPages: totalPages || 1 })}</span>
          <Button
            variant="outline"
            size="icon-sm"
            disabled={page >= totalPages}
            onClick={() => onPageChange(page + 1)}
          >
            <ChevronRight className="size-4" />
          </Button>
        </div>
      </div>
    </div>
  );
}

function PagedTableRow<T>({
  item,
  columns,
  renderExpandedRow,
}: {
  item: T;
  columns: PagedTableColumn<T>[];
  renderExpandedRow?: (item: T) => ReactNode;
}) {
  const [isExpanded, setIsExpanded] = useState(false);
  const t = useTranslations("table");

  return (
    <>
      <TableRow>
        {columns.map((column) => (
          <TableCell key={column.key}>{column.render(item)}</TableCell>
        ))}
        {renderExpandedRow && (
          <TableCell>
            <Button variant="ghost" size="sm" onClick={() => setIsExpanded((prev) => !prev)}>
              {isExpanded ? t("hideDetails") : t("showDetails")}
            </Button>
          </TableCell>
        )}
      </TableRow>
      {renderExpandedRow && isExpanded && (
        <TableRow>
          <TableCell colSpan={columns.length + 1}>{renderExpandedRow(item)}</TableCell>
        </TableRow>
      )}
    </>
  );
}
