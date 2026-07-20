"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { Building, Building2, Receipt, ShieldCheck, Users } from "lucide-react";
import { useAuth } from "@/contexts/AuthContext";
import { apiFetch } from "@/lib/api";
import { formatDate } from "@/lib/formatDate";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { StatCard } from "@/components/stat-card";
import type { AdminDashboardResponse, FirmDashboardResponse } from "@/lib/dashboardTypes";

function formatAmount(value: number): string {
  return value.toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

export default function HomePage() {
  const { user, isLoading: authLoading } = useAuth();
  const t = useTranslations("home");
  const tRoles = useTranslations("roles");
  const tDashboard = useTranslations("dashboard");

  const [adminData, setAdminData] = useState<AdminDashboardResponse | null>(null);
  const [firmData, setFirmData] = useState<FirmDashboardResponse | null>(null);
  const [isLoadingSummary, setIsLoadingSummary] = useState(true);

  useEffect(() => {
    if (authLoading || !user) {
      return;
    }

    const currentUser = user;
    let isCancelled = false;

    async function load() {
      setIsLoadingSummary(true);

      try {
        if (currentUser.role === "Admin") {
          const result = await apiFetch<AdminDashboardResponse>("/api/Dashboard/admin-summary");
          if (!isCancelled) {
            setAdminData(result);
          }
        } else {
          const result = await apiFetch<FirmDashboardResponse>("/api/Dashboard/summary");
          if (!isCancelled) {
            setFirmData(result);
          }
        }
      } finally {
        if (!isCancelled) {
          setIsLoadingSummary(false);
        }
      }
    }

    load();

    return () => {
      isCancelled = true;
    };
  }, [authLoading, user]);

  if (authLoading) {
    return null;
  }

  const isAdmin = user?.role === "Admin";
  const roleLabel = isAdmin ? tRoles("admin") : tRoles("firm");
  const hasAnyFirmStats =
    firmData !== null &&
    (firmData.invoiceStats !== null ||
      firmData.customerCount !== null ||
      firmData.userCount !== null ||
      firmData.profileCount !== null);

  return (
    <div className="flex flex-col gap-6">
      <p className="text-lg">
        {t("greetingPrefix")} <span className="font-semibold">{user?.userName}</span> ({roleLabel})
      </p>

      {isLoadingSummary && <p className="text-sm text-muted-foreground">{tDashboard("loading")}</p>}

      {!isLoadingSummary && isAdmin && adminData && (
        <>
          <div className="grid gap-4 sm:grid-cols-2">
            <StatCard label={tDashboard("totalFirms")} value={String(adminData.totalFirmCount)} icon={Building} />
            <StatCard
              label={tDashboard("newFirmsThisMonth")}
              value={String(adminData.newFirmsThisMonth)}
              icon={Building2}
            />
          </div>

          <Card>
            <CardHeader>
              <CardTitle>{tDashboard("recentFirms")}</CardTitle>
            </CardHeader>
            <CardContent>
              {adminData.recentFirms.length === 0 ? (
                <p className="text-sm text-muted-foreground">{tDashboard("noRecentFirms")}</p>
              ) : (
                <ul className="flex flex-col gap-2">
                  {adminData.recentFirms.map((firm) => (
                    <li key={firm.firmId} className="flex items-center justify-between border-b py-2 last:border-0">
                      <span className="font-medium">{firm.name}</span>
                      <span className="text-sm text-muted-foreground">{formatDate(firm.createdDate)}</span>
                    </li>
                  ))}
                </ul>
              )}
            </CardContent>
          </Card>
        </>
      )}

      {!isLoadingSummary && !isAdmin && firmData && !hasAnyFirmStats && (
        <p className="text-sm text-muted-foreground">{tDashboard("noWidgets")}</p>
      )}

      {!isLoadingSummary && !isAdmin && firmData && hasAnyFirmStats && (
        <>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {firmData.invoiceStats && (
              <>
                <StatCard
                  label={tDashboard("totalInvoices")}
                  value={String(firmData.invoiceStats.totalInvoiceCount)}
                  icon={Receipt}
                />
                <StatCard
                  label={tDashboard("totalRevenue")}
                  value={formatAmount(firmData.invoiceStats.totalRevenue)}
                  icon={Receipt}
                />
              </>
            )}
            {firmData.customerCount !== null && (
              <StatCard
                label={tDashboard("totalCustomers")}
                value={String(firmData.customerCount)}
                icon={Building2}
              />
            )}
            {firmData.userCount !== null && (
              <StatCard label={tDashboard("totalUsers")} value={String(firmData.userCount)} icon={Users} />
            )}
            {firmData.profileCount !== null && (
              <StatCard
                label={tDashboard("totalProfiles")}
                value={String(firmData.profileCount)}
                icon={ShieldCheck}
              />
            )}
          </div>

          {firmData.invoiceStats && (
            <Card>
              <CardHeader>
                <CardTitle>{tDashboard("recentInvoices")}</CardTitle>
              </CardHeader>
              <CardContent>
                {firmData.invoiceStats.recentInvoices.length === 0 ? (
                  <p className="text-sm text-muted-foreground">{tDashboard("noRecentInvoices")}</p>
                ) : (
                  <ul className="flex flex-col gap-2">
                    {firmData.invoiceStats.recentInvoices.map((invoice) => (
                      <li
                        key={invoice.invoiceId}
                        className="flex items-center justify-between border-b py-2 last:border-0"
                      >
                        <div className="flex flex-col">
                          <span className="font-medium">{invoice.invoiceNumber}</span>
                          <span className="text-sm text-muted-foreground">{invoice.customerTitle}</span>
                        </div>
                        <div className="flex flex-col items-end">
                          <span className="font-medium">{formatAmount(invoice.grandTotal)}</span>
                          <span className="text-sm text-muted-foreground">{formatDate(invoice.invoiceDate)}</span>
                        </div>
                      </li>
                    ))}
                  </ul>
                )}
              </CardContent>
            </Card>
          )}
        </>
      )}
    </div>
  );
}