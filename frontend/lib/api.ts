import { getToken, clearToken } from "@/lib/authClient";

const API_URL = process.env.NEXT_PUBLIC_API_URL;

export class ApiError extends Error {
  status: number;
  errorCode: string;
  params: Record<string, string>;

  constructor(errorCode: string, status: number, params: Record<string, string> = {}) {
    super(errorCode);
    this.status = status;
    this.errorCode = errorCode;
    this.params = params;
  }
}

export async function apiFetch<T>(path: string, options: RequestInit = {}): Promise<T> {
  const token = getToken();

  const headers = new Headers(options.headers);
  headers.set("Content-Type", "application/json");

  if (token) {
    headers.set("Authorization", `Bearer ${token}`);
  }

  const response = await fetch(`${API_URL}${path}`, { ...options, headers });

  if (response.status === 401) {
    clearToken();
    window.location.href = "/login";
    throw new ApiError("SESSION_EXPIRED", 401);
  }

  if (!response.ok) {
    const body = await response.json().catch(() => null);
    throw new ApiError(body?.errorCode ?? "UNEXPECTED_ERROR", response.status, body?.parameters ?? {});
  }

  if (response.status === 204) {
    return undefined as T;
  }

  return response.json() as Promise<T>;
}

export async function apiFetchText(path: string, options: RequestInit = {}): Promise<string> {
  const token = getToken();

  const headers = new Headers(options.headers);

  if (token) {
    headers.set("Authorization", `Bearer ${token}`);
  }

  const response = await fetch(`${API_URL}${path}`, { ...options, headers });

  if (response.status === 401) {
    clearToken();
    window.location.href = "/login";
    throw new ApiError("SESSION_EXPIRED", 401);
  }

  if (!response.ok) {
    const body = await response.json().catch(() => null);
    throw new ApiError(body?.errorCode ?? "UNEXPECTED_ERROR", response.status, body?.parameters ?? {});
  }

  return response.text();
}

function extractFileName(disposition: string | null): string | null {
  if (!disposition) {
    return null;
  }

  const match = disposition.match(/filename\*?=(?:UTF-8'')?"?([^";]+)"?/i);
  return match ? decodeURIComponent(match[1]) : null;
}

export async function apiDownload(path: string, fallbackFileName: string): Promise<void> {
  const token = getToken();

  const headers = new Headers();

  if (token) {
    headers.set("Authorization", `Bearer ${token}`);
  }

  const response = await fetch(`${API_URL}${path}`, { headers });

  if (response.status === 401) {
    clearToken();
    window.location.href = "/login";
    throw new ApiError("SESSION_EXPIRED", 401);
  }

  if (!response.ok) {
    const body = await response.json().catch(() => null);
    throw new ApiError(body?.errorCode ?? "UNEXPECTED_ERROR", response.status, body?.parameters ?? {});
  }

  const fileName = extractFileName(response.headers.get("Content-Disposition")) ?? fallbackFileName;

  const blob = await response.blob();
  const objectUrl = URL.createObjectURL(blob);

  const link = document.createElement("a");
  link.href = objectUrl;
  link.download = fileName;
  document.body.appendChild(link);
  link.click();
  link.remove();

  URL.revokeObjectURL(objectUrl);
}