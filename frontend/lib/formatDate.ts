export function formatDateTime(isoString: string | null): string {
  if (!isoString) {
    return "-";
  }

  return new Date(isoString).toLocaleString("tr-TR", {
    dateStyle: "medium",
    timeStyle: "short",
  });
}