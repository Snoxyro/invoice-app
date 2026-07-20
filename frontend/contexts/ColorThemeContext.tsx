"use client";

import { createContext, useContext, useEffect, useState } from "react";

export const colorThemes = ["default", "blue", "green", "purple"] as const;
export type ColorTheme = (typeof colorThemes)[number];

const STORAGE_KEY = "invoiceapp-color-theme";

interface ColorThemeContextValue {
  colorTheme: ColorTheme;
  setColorTheme: (theme: ColorTheme) => void;
}

const ColorThemeContext = createContext<ColorThemeContextValue | null>(null);

function isColorTheme(value: string | null): value is ColorTheme {
  return !!value && (colorThemes as readonly string[]).includes(value);
}

export function ColorThemeProvider({ children }: { children: React.ReactNode }) {
  const [colorTheme, setColorThemeState] = useState<ColorTheme>("default");

  useEffect(() => {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (isColorTheme(stored)) {
      setColorThemeState(stored);
    }
  }, []);

  useEffect(() => {
    const root = document.documentElement;
    if (colorTheme === "default") {
      root.removeAttribute("data-color-theme");
    } else {
      root.setAttribute("data-color-theme", colorTheme);
    }
  }, [colorTheme]);

  function setColorTheme(theme: ColorTheme) {
    setColorThemeState(theme);
    localStorage.setItem(STORAGE_KEY, theme);
  }

  return (
    <ColorThemeContext.Provider value={{ colorTheme, setColorTheme }}>
      {children}
    </ColorThemeContext.Provider>
  );
}

export function useColorTheme() {
  const context = useContext(ColorThemeContext);

  if (!context) {
    throw new Error("useColorTheme must be used within a ColorThemeProvider");
  }

  return context;
}
