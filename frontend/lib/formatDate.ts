export function formatDateTime(isoString: string | null, locale: string = "tr-TR"): string {
  if (!isoString) {
    return "-";
  }

  return new Date(isoString).toLocaleString(locale, {
    dateStyle: "medium",
    timeStyle: "short",
  });
}