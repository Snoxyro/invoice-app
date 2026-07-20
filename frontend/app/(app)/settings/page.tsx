"use client";

import { useTransition } from "react";
import { useRouter } from "next/navigation";
import { useLocale, useTranslations } from "next-intl";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { locales, localeLabels, type Locale } from "@/i18n/locales";
import { setLocale } from "@/lib/localeActions";
import { ThemeToggle } from "@/components/theme-toggle";
import { ColorThemePicker } from "@/components/color-theme-picker";
import type { ColorTheme } from "@/contexts/ColorThemeContext";

export default function SettingsPage() {
  const t = useTranslations("settings");
  const locale = useLocale();
  const router = useRouter();
  const [isPending, startTransition] = useTransition();

  function handleLocaleChange(value: string | null) {
    if (!value) {
      return;
    }

    startTransition(async () => {
      await setLocale(value);
      router.refresh();
    });
  }

  const colorThemeLabels: Record<ColorTheme, string> = {
    default: t("colorDefault"),
    blue: t("colorBlue"),
    green: t("colorGreen"),
    purple: t("colorPurple"),
  };

  return (
    <div className="mx-auto max-w-md p-6">
      <h1 className="mb-4 text-2xl font-semibold">{t("title")}</h1>
      <div className="flex flex-col gap-4">
        <Card>
          <CardHeader>
            <CardTitle>{t("languageTitle")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex flex-col gap-2">
              <Label htmlFor="locale-select">{t("languageLabel")}</Label>
              <Select value={locale} onValueChange={handleLocaleChange} disabled={isPending}>
                <SelectTrigger id="locale-select" className="w-48">
                  <SelectValue>
                    {(value: string | null) => (value ? localeLabels[value as Locale] : "")}
                  </SelectValue>
                </SelectTrigger>
                <SelectContent alignItemWithTrigger={false}>
                  {locales.map((code) => (
                    <SelectItem key={code} value={code}>
                      {localeLabels[code]}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("appearanceTitle")}</CardTitle>
          </CardHeader>
          <CardContent className="flex flex-col gap-5">
            <div className="flex flex-col gap-2">
              <Label>{t("themeLabel")}</Label>
              <ThemeToggle lightLabel={t("themeLight")} darkLabel={t("themeDark")} />
            </div>
            <div className="flex flex-col gap-2">
              <Label>{t("colorThemeLabel")}</Label>
              <ColorThemePicker labels={colorThemeLabels} />
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
