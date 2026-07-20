export interface RecentFirmItem {
  firmId: number;
  name: string;
  createdDate: string;
}

export interface AdminDashboardResponse {
  totalFirmCount: number;
  newFirmsThisMonth: number;
  recentFirms: RecentFirmItem[];
}

export interface RecentInvoiceItem {
  invoiceId: number;
  invoiceNumber: string;
  customerTitle: string;
  grandTotal: number;
  invoiceDate: string;
}

export interface InvoiceStatsResponse {
  totalInvoiceCount: number;
  invoiceCountThisMonth: number;
  totalRevenue: number;
  revenueThisMonth: number;
  recentInvoices: RecentInvoiceItem[];
}

export interface FirmDashboardResponse {
  invoiceStats: InvoiceStatsResponse | null;
  customerCount: number | null;
  newCustomersThisMonth: number | null;
  userCount: number | null;
  profileCount: number | null;
}
