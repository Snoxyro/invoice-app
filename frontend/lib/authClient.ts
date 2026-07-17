import { TOKEN_COOKIE_NAME } from "@/lib/jwt";

export function setToken(token: string): void {
  document.cookie = `${TOKEN_COOKIE_NAME}=${token}; path=/; max-age=${60 * 60 * 24}; samesite=lax`;
}

export function getToken(): string | null {
  const match = document.cookie.match(new RegExp(`(?:^|; )${TOKEN_COOKIE_NAME}=([^;]*)`));
  return match ? decodeURIComponent(match[1]) : null;
}

export function clearToken(): void {
  document.cookie = `${TOKEN_COOKIE_NAME}=; path=/; max-age=0`;
}