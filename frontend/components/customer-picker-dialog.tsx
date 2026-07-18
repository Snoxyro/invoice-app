"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { ChevronLeft, ChevronRight, Plus } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { CustomerFormDialog } from "@/components/customer-form-dialog";
import { usePagedList } from "@/hooks/usePagedList";

interface CustomerResponse {
  customerId: number;
  taxNumber: string;
  title: string;
  address: string;
  email: string;
  createdDate: string;
  updatedDate: string | null;
}

interface CustomerPickerDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onSelect: (customer: CustomerResponse) => void;
}

export function CustomerPickerDialog({
  open,
  onOpenChange,
  onSelect,
}: CustomerPickerDialogProps) {
  const t = useTranslations("invoices");
  const tTable = useTranslations("table");

  const list = usePagedList<CustomerResponse>("/api/Customers", { pageSize: 10 });
  const [createOpen, setCreateOpen] = useState(false);

  function handleSelect(customer: CustomerResponse) {
    onSelect(customer);
    onOpenChange(false);
  }

  return (
    <>
      <Dialog open={open} onOpenChange={onOpenChange}>
        <DialogContent className="sm:max-w-lg">
          <DialogHeader>
            <DialogTitle>{t("selectCustomerTitle")}</DialogTitle>
            <DialogDescription>{t("selectCustomerDescription")}</DialogDescription>
          </DialogHeader>

          <div className="flex flex-col gap-3 px-4">
            <div className="flex items-center gap-2">
              <Input
                placeholder={t("selectCustomerSearchPlaceholder")}
                value={list.searchInput}
                onChange={(e) => list.setSearchInput(e.target.value)}
              />
              <Button type="button" variant="outline" onClick={() => setCreateOpen(true)}>
                <Plus />
                {t("newCustomerButton")}
              </Button>
            </div>

            <div className="flex max-h-80 flex-col gap-1 overflow-y-auto">
              {list.isLoading && (
                <p className="py-4 text-center text-sm text-muted-foreground">
                  {t("selectCustomerLoading")}
                </p>
              )}

              {!list.isLoading && (list.data?.items.length ?? 0) === 0 && (
                <p className="py-4 text-center text-sm text-muted-foreground">
                  {t("selectCustomerEmpty")}
                </p>
              )}

              {!list.isLoading &&
                list.data?.items.map((customer) => (
                  <button
                    key={customer.customerId}
                    type="button"
                    onClick={() => handleSelect(customer)}
                    className="flex flex-col items-start rounded-md border p-3 text-left hover:bg-muted"
                  >
                    <span className="font-medium">{customer.title}</span>
                    <span className="text-sm text-muted-foreground">{customer.taxNumber}</span>
                  </button>
                ))}
            </div>

            {!list.isLoading && (list.data?.items.length ?? 0) > 0 && (
              <div className="flex items-center justify-between text-sm text-muted-foreground">
                <span>{tTable("totalRecords", { count: list.data?.totalCount ?? 0 })}</span>
                <div className="flex items-center gap-2">
                  <Button
                    type="button"
                    variant="outline"
                    size="icon-sm"
                    disabled={list.page <= 1}
                    onClick={() => list.setPage(list.page - 1)}
                  >
                    <ChevronLeft className="size-4" />
                  </Button>
                  <span>
                    {tTable("pageOf", {
                      page: list.page,
                      totalPages: list.data?.totalPages || 1,
                    })}
                  </span>
                  <Button
                    type="button"
                    variant="outline"
                    size="icon-sm"
                    disabled={list.page >= (list.data?.totalPages ?? 1)}
                    onClick={() => list.setPage(list.page + 1)}
                  >
                    <ChevronRight className="size-4" />
                  </Button>
                </div>
              </div>
            )}
          </div>
        </DialogContent>
      </Dialog>

      <CustomerFormDialog
        open={createOpen}
        onOpenChange={setCreateOpen}
        customer={null}
        onSuccess={(customer) => handleSelect(customer)}
      />
    </>
  );
}