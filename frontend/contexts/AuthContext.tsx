"use client";

import { createContext, useContext, useEffect, useState, type ReactNode } from "react";
import { useRouter } from "next/navigation";
import { decodeJwt, isTokenExpired, type DecodedToken } from "@/lib/jwt";
import { getToken, setToken, clearToken } from "@/lib/authClient";
import { ApiError } from "@/lib/api";

interface AuthContextValue {
  user: DecodedToken | null;
  isLoading: boolean;
  login: (userName: string, password: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<DecodedToken | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    const token = getToken();

    if (token) {
      const decoded = decodeJwt(token);

      if (decoded && !isTokenExpired(decoded.exp)) {
        setUser(decoded);
      } else {
        clearToken();
      }
    }

    setIsLoading(false);
  }, []);

  async function login(userName: string, password: string) {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/Auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ userName, password }),
    });

    if (!response.ok) {
      const body = await response.json().catch(() => null);
      throw new ApiError(body?.message ?? "Giriş başarısız", response.status);
    }

    const data: { token: string } = await response.json();
    setToken(data.token);

    const decoded = decodeJwt(data.token);
    setUser(decoded);

    router.push("/");
  }

  function logout() {
    clearToken();
    setUser(null);
    router.push("/login");
  }

  return (
    <AuthContext.Provider value={{ user, isLoading, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth(): AuthContextValue {
  const context = useContext(AuthContext);

  if (!context) {
    throw new Error("useAuth must be used within AuthProvider");
  }

  return context;
}