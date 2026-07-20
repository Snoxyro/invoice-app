"use client";

import { Check } from "lucide-react";
import { cn } from "@/lib/utils";
import { colorThemes, useColorTheme, type ColorTheme } from "@/contexts/ColorThemeContext";

const swatchColors: Record<ColorTheme, string> = {
  default: "oklch(0.45 0 0)",
  blue: "oklch(0.551 0.163 259.234)",
  green: "oklch(0.548 0.146 148.5)",
  purple: "oklch(0.521 0.196 303.5)",
};

interface ColorThemePickerProps {
  labels: Record<ColorTheme, string>;
}

export function ColorThemePicker({ labels }: ColorThemePickerProps) {
  const { colorTheme, setColorTheme } = useColorTheme();

  return (
    <div className="flex flex-wrap gap-3">
      {colorThemes.map((themeOption) => (
        <button
          key={themeOption}
          type="button"
          onClick={() => setColorTheme(themeOption)}
          title={labels[themeOption]}
          className={cn(
            "flex size-9 items-center justify-center rounded-full border-2 transition-colors",
            colorTheme === themeOption ? "border-foreground" : "border-transparent"
          )}
        >
          <span
            className="flex size-7 items-center justify-center rounded-full border border-border"
            style={{ backgroundColor: swatchColors[themeOption] }}
          >
            {colorTheme === themeOption && <Check className="size-4 text-white" />}
          </span>
        </button>
      ))}
    </div>
  );
}