"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";
import { PermissionGuard } from "@/components/permission-guard";
import { FirmBrandingSection } from "@/components/firm-branding-section";
import { BankAccountsSection } from "@/components/bank-accounts-section";
import { usePermissions } from "@/contexts/PermissionContext";

export default function InvoiceSettingsPage() {
  const t = useTranslations("invoiceSettings");
  const { hasPermission } = usePermissions();

  const canCreate = hasPermission("InvoiceSettings", "Create");
  const canUpdate = hasPermission("InvoiceSettings", "Update");
  const canDelete = hasPermission("InvoiceSettings", "Delete");

  const [previewRefreshKey, setPreviewRefreshKey] = useState(0);

  function triggerPreviewRefresh() {
    setPreviewRefreshKey((key) => key + 1);
  }

  return (
    <PermissionGuard resource="InvoiceSettings" action="Read">
      <div className="flex flex-col gap-6">
        <h1 className="text-2xl font-semibold">{t("title")}</h1>

        <FirmBrandingSection canUpdate={canUpdate} previewRefreshKey={previewRefreshKey} />
        <BankAccountsSection
          canCreate={canCreate}
          canUpdate={canUpdate}
          canDelete={canDelete}
          onDataChanged={triggerPreviewRefresh}
        />
      </div>
    </PermissionGuard>
  );
}
