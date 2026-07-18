import { useTranslations } from "next-intl";
import { ApiError } from "@/lib/api";

type ErrorsTranslator = ReturnType<typeof useTranslations>;

export function getApiErrorMessage(err: unknown, tErrors: ErrorsTranslator, fallback: string): string {
  if (err instanceof ApiError && tErrors.has(err.errorCode)) {
    return tErrors(err.errorCode, err.params);
  }

  return fallback;
}