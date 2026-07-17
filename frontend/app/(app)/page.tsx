"use client";

import { useAuth } from "@/contexts/AuthContext";

export default function HomePage() {
  const { user, isLoading } = useAuth();

  if (isLoading) {
    return null;
  }

  return (
    <div className="p-6">
      <p className="text-lg">
        Merhaba, <span className="font-semibold">{user?.userName}</span> ({user?.role})
      </p>
    </div>
  );
}