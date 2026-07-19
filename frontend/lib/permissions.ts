export type PermissionResource = "Users" | "Profiles" | "Customers" | "Invoices";
export type PermissionActionType = "Create" | "Read" | "Update" | "Delete";

export interface MyPermissionsResponse {
  profileId: number | null;
  isSystemProfile: boolean;
  permissions: string[];
  vatRateIds: number[];
  minInvoiceAmount: number | null;
  maxInvoiceAmount: number | null;
}

export function permissionKey(resource: PermissionResource, action: PermissionActionType): string {
  return `${resource}:${action}`;
}
