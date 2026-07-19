export type PermissionResource = "Users" | "Profiles" | "Customers" | "Invoices";
export type PermissionActionType = "Create" | "Read" | "Update" | "Delete";

export interface VatRateOption {
  vatRateId: number;
  rate: number;
}

export interface MyPermissionsResponse {
  profileId: number | null;
  isSystemProfile: boolean;
  permissions: string[];
  vatRates: VatRateOption[];
  minInvoiceAmount: number | null;
  maxInvoiceAmount: number | null;
}

export function permissionKey(resource: PermissionResource, action: PermissionActionType): string {
  return `${resource}:${action}`;
}
