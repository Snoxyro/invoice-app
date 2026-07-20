"use client";

import { createContext, useCallback, useContext, useEffect, useState, type ReactNode } from "react";
import { apiFetch } from "@/lib/api";
import { useAuth } from "@/contexts/AuthContext";
import {
  permissionKey,
  type MyPermissionsResponse,
  type PermissionActionType,
  type PermissionResource,
  type VatRateOption,
} from "@/lib/permissions";

interface PermissionContextValue {
  isLoading: boolean;
  profileId: number | null;
  profileName: string | null;
  isSystemProfile: boolean;
  vatRates: VatRateOption[];
  minInvoiceAmount: number | null;
  maxInvoiceAmount: number | null;
  hasPermission: (resource: PermissionResource, action: PermissionActionType) => boolean;
}

const PermissionContext = createContext<PermissionContextValue | undefined>(undefined);

export function PermissionProvider({ children }: { children: ReactNode }) {
  const { user } = useAuth();
  const [data, setData] = useState<MyPermissionsResponse | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const load = useCallback(async () => {
    if (!user) {
      setData(null);
      setIsLoading(false);
      return;
    }

    setIsLoading(true);

    try {
      const result = await apiFetch<MyPermissionsResponse>("/api/Me/permissions");
      setData(result);
    } finally {
      setIsLoading(false);
    }
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  function hasPermission(resource: PermissionResource, action: PermissionActionType): boolean {
    return data?.permissions.includes(permissionKey(resource, action)) ?? false;
  }

  return (
    <PermissionContext.Provider
      value={{
        isLoading,
        profileId: data?.profileId ?? null,
        profileName: data?.profileName ?? null,
        isSystemProfile: data?.isSystemProfile ?? false,
        vatRates: data?.vatRates ?? [],
        minInvoiceAmount: data?.minInvoiceAmount ?? null,
        maxInvoiceAmount: data?.maxInvoiceAmount ?? null,
        hasPermission,
      }}
    >
      {children}
    </PermissionContext.Provider>
  );
}

export function usePermissions(): PermissionContextValue {
  const context = useContext(PermissionContext);

  if (!context) {
    throw new Error("usePermissions must be used within PermissionProvider");
  }

  return context;
}