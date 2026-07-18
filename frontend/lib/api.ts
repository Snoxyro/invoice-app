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