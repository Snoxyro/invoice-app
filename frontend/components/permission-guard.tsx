"use client";

import { useEffect, type ReactNode } from "react";
import { useRouter } from "next/navigation";
import { usePermissions } from "@/contexts/PermissionContext";
import type { PermissionActionType, PermissionResource } from "@/lib/permissions";

interface PermissionGuardProps {
  resource: PermissionResource;
  action: PermissionActionType;
  children: ReactNode;
}

export function PermissionGuard({ resource, action, children }: PermissionGuardProps) {
  const { isLoading, hasPermission } = usePermissions();
  const router = useRouter();
  const allowed = hasPermission(resource, action);

  useEffect(() => {
    if (!isLoading && !allowed) {
      router.replace("/");
    }
  }, [isLoading, allowed, router]);

  if (isLoading || !allowed) {
    return null;
  }

  return <>{children}</>;
}
