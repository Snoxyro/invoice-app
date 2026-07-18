"use client";

import { useTranslations } from "next-intl";
import { useAuth } from "@/contexts/AuthContext";

export default function HomePage() {
  const { user, isLoading } = useAuth();
  const t = useTranslations("home");
  const tRoles = useTranslations("roles");

  if (isLoading) {
    return null;
  }

  const roleLabel = user?.role === "Admin" ? tRoles("admin") : tRoles("firm");

  return (
    <div className="p-6">
      <p className="text-lg">
        {t("greetingPrefix")} <span className="font-semibold">{user?.userName}</span> ({roleLabel})
      </p>
    </div>
  );
}