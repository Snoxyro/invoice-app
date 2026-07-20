"use client";

import { useEffect, useState } from "react";
import { useTheme } from "next-themes";
import { Moon, Sun } from "lucide-react";
import { Button } from "@/components/ui/button";

interface ThemeToggleProps {
  lightLabel: string;
  darkLabel: string;
}

export function ThemeToggle({ lightLabel, darkLabel }: ThemeToggleProps) {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return <div className="h-8 w-44" />;
  }

  return (
    <div className="flex w-fit gap-1 rounded-lg border border-border p-1">
      <Button
        type="button"
        variant={theme === "light" ? "secondary" : "ghost"}
        size="sm"
        onClick={() => setTheme("light")}
      >
        <Sun />
        {lightLabel}
      </Button>
      <Button
        type="button"
        variant={theme === "dark" ? "secondary" : "ghost"}
        size="sm"
        onClick={() => setTheme("dark")}
      >
        <Moon />
        {darkLabel}
      </Button>
    </div>
  );
}
