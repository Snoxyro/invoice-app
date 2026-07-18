export const locales = ["tr", "en"] as const;
export type Locale = (typeof locales)[number];
export const defaultLocale: Locale = "tr";
export const LOCALE_COOKIE_NAME = "NEXT_LOCALE";

export const localeLabels: Record<Locale, string> = {
  tr: "Türkçe",
  en: "English",
};

export function isSupportedLocale(value: string | undefined): value is Locale {
  return !!value && (locales as readonly string[]).includes(value);
}