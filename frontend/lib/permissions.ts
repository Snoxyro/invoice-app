export type PermissionResource =
  | "Users"
  | "Profiles"
  | "Customers"
  | "Invoices"
  | "Branches"
  | "InvoiceCustomization";
export type PermissionActionType = "Create" | "Read" | "Update" | "Delete";

export interface VatRateOption {
  vatRateId: number;
  rate: number;
  isExemption: boolean;
}

export interface InvoiceSeriesOption {
  invoiceSeriesId: number;
  prefix: string;
}

export interface BranchOption {
  branchId: number;
  name: string;
  isHeadquarters: boolean;
}

export interface MyPermissionsResponse {
  profileId: number | null;
  profileName: string | null;
  isSystemProfile: boolean;
  permissions: string[];
  vatRates: VatRateOption[];
  minInvoiceAmount: number | null;
  maxInvoiceAmount: number | null;
  canAccessAllBranches: boolean;
  canCreateSalesInvoices: boolean;
  canCreateReturnInvoices: boolean;
  branchId: number | null;
  availableInvoiceSeries: InvoiceSeriesOption[];
  availableBranches: BranchOption[];
}

export function permissionKey(resource: PermissionResource, action: PermissionActionType): string {
  return `${resource}:${action}`;
}
