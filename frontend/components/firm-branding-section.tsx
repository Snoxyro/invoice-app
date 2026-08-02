"use client";

import { useEffect, useState, type ChangeEvent } from "react";
import { useTranslations } from "next-intl";
import { Upload } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { apiFetch, apiFetchText } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";
import { resizeImageToBase64, ImageTooLargeError } from "@/lib/imageResize";
import { ZoomableInvoicePreview } from "@/components/zoomable-invoice-preview";

interface FirmBrandingResponse {
  logoBase64: string | null;
  stampBase64: string | null;
  accentColorHex: string | null;
  fontFamily: string | null;
  logoWidthPx: number | null;
  logoHeightPx: number | null;
  stampWidthPx: number | null;
  stampHeightPx: number | null;
}

const FONT_OPTIONS = ["Inter", "Arial", "Times New Roman", "Georgia", "Roboto"];
const LOGO_MAX_UPLOAD_DIMENSION = 400;
const STAMP_MAX_UPLOAD_DIMENSION = 400;
const PREVIEW_DEBOUNCE_MS = 500;
const HEX_COLOR_PATTERN = /^#[0-9A-Fa-f]{6}$/;

interface FirmBrandingSectionProps {
  canUpdate: boolean;
  previewRefreshKey: number;
}

export function FirmBrandingSection({ canUpdate, previewRefreshKey }: FirmBrandingSectionProps) {
  const t = useTranslations("invoiceSettings");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const [logoBase64, setLogoBase64] = useState<string | null>(null);
  const [stampBase64, setStampBase64] = useState<string | null>(null);
  const [accentColorHex, setAccentColorHex] = useState("");
  const [fontFamily, setFontFamily] = useState<string | null>(null);
  const [logoWidthPx, setLogoWidthPx] = useState("");
  const [logoHeightPx, setLogoHeightPx] = useState("");
  const [stampWidthPx, setStampWidthPx] = useState("");
  const [stampHeightPx, setStampHeightPx] = useState("");

  const [isLoading, setIsLoading] = useState(true);
  const [isSaving, setIsSaving] = useState(false);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [saveSuccess, setSaveSuccess] = useState(false);

  const [previewHtml, setPreviewHtml] = useState<string | null>(null);
  const [isPreviewLoading, setIsPreviewLoading] = useState(false);
  const [previewError, setPreviewError] = useState<string | null>(null);

  useEffect(() => {
    let isCancelled = false;

    async function load() {
      setIsLoading(true);
      setLoadError(null);

      try {
        const result = await apiFetch<FirmBrandingResponse>("/api/FirmBranding");

        if (!isCancelled) {
          setLogoBase64(result.logoBase64);
          setStampBase64(result.stampBase64);
          setAccentColorHex(result.accentColorHex ?? "");
          setFontFamily(result.fontFamily);
          setLogoWidthPx(result.logoWidthPx?.toString() ?? "");
          setLogoHeightPx(result.logoHeightPx?.toString() ?? "");
          setStampWidthPx(result.stampWidthPx?.toString() ?? "");
          setStampHeightPx(result.stampHeightPx?.toString() ?? "");
        }
      } catch (err) {
        if (!isCancelled) {
          setLoadError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
        }
      } finally {
        if (!isCancelled) {
          setIsLoading(false);
        }
      }
    }

    load();

    return () => {
      isCancelled = true;
    };
  }, [tErrors]);

  function buildPayload() {
    return {
      logoBase64,
      stampBase64,
      accentColorHex: accentColorHex || null,
      fontFamily,
      logoWidthPx: logoWidthPx ? Number(logoWidthPx) : null,
      logoHeightPx: logoHeightPx ? Number(logoHeightPx) : null,
      stampWidthPx: stampWidthPx ? Number(stampWidthPx) : null,
      stampHeightPx: stampHeightPx ? Number(stampHeightPx) : null,
    };
  }

  useEffect(() => {
    if (isLoading) {
      return;
    }

    const timeoutId = window.setTimeout(() => {
      setIsPreviewLoading(true);

      apiFetchText("/api/FirmBranding/preview", {
        method: "POST",
        body: JSON.stringify(buildPayload()),
      })
        .then((html) => {
          setPreviewHtml(html);
          setPreviewError(null);
        })
        .catch((err) => {
          setPreviewError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
        })
        .finally(() => setIsPreviewLoading(false));
    }, PREVIEW_DEBOUNCE_MS);

    return () => window.clearTimeout(timeoutId);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [
    isLoading,
    logoBase64,
    stampBase64,
    accentColorHex,
    fontFamily,
    logoWidthPx,
    logoHeightPx,
    stampWidthPx,
    stampHeightPx,
    previewRefreshKey,
  ]);

  async function handleFileChange(
    event: ChangeEvent<HTMLInputElement>,
    maxDimension: number,
    setValue: (value: string) => void
  ) {
    const file = event.target.files?.[0];
    event.target.value = "";

    if (!file) {
      return;
    }

    try {
      const base64 = await resizeImageToBase64(file, maxDimension);
      setValue(base64);
      setSaveError(null);
    } catch (err) {
      setSaveError(err instanceof ImageTooLargeError ? t("uploadTooLarge") : t("uploadFailed"));
    }
  }

  async function handleSave() {
    setIsSaving(true);
    setSaveError(null);
    setSaveSuccess(false);

    try {
      await apiFetch("/api/FirmBranding", {
        method: "PUT",
        body: JSON.stringify(buildPayload()),
      });
      setSaveSuccess(true);
    } catch (err) {
      setSaveError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setIsSaving(false);
    }
  }

  if (isLoading) {
    return (
      <Card>
        <CardContent className="py-8 text-center text-sm text-muted-foreground">
          {tCommon("loading")}
        </CardContent>
      </Card>
    );
  }

  if (loadError) {
    return (
      <Card>
        <CardContent className="py-8 text-center text-sm text-destructive">{loadError}</CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t("brandingTitle")}</CardTitle>
        <CardDescription>{t("brandingDescription")}</CardDescription>
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
          <div className="flex flex-col gap-5">
            <div className="flex flex-col gap-2">
              <Label>{t("logoLabel")}</Label>
              <div className="flex items-center gap-3">
                {logoBase64 && (
                  <img src={logoBase64} alt="" className="h-12 w-12 rounded border object-contain" />
                )}
                <label className="flex h-8 cursor-pointer items-center gap-2 rounded-lg border border-input px-3 text-sm hover:bg-accent">
                  <Upload className="size-4" />
                  {t("uploadButton")}
                  <input
                    type="file"
                    accept="image/*"
                    className="hidden"
                    onChange={(e) => handleFileChange(e, LOGO_MAX_UPLOAD_DIMENSION, setLogoBase64)}
                    disabled={!canUpdate}
                  />
                </label>
                {logoBase64 && (
                  <Button type="button" variant="ghost" size="sm" onClick={() => setLogoBase64(null)}>
                    {tCommon("remove")}
                  </Button>
                )}
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div className="flex flex-col gap-1">
                  <Label htmlFor="logoWidthPx" className="text-xs text-muted-foreground">
                    {t("widthPxLabel")}
                  </Label>
                  <Input
                    id="logoWidthPx"
                    type="number"
                    min={1}
                    max={255}
                    value={logoWidthPx}
                    onChange={(e) => setLogoWidthPx(e.target.value)}
                    disabled={!canUpdate}
                  />
                </div>
                <div className="flex flex-col gap-1">
                  <Label htmlFor="logoHeightPx" className="text-xs text-muted-foreground">
                    {t("heightPxLabel")}
                  </Label>
                  <Input
                    id="logoHeightPx"
                    type="number"
                    min={1}
                    max={255}
                    value={logoHeightPx}
                    onChange={(e) => setLogoHeightPx(e.target.value)}
                    disabled={!canUpdate}
                  />
                </div>
              </div>
            </div>

            <div className="flex flex-col gap-2">
              <Label>{t("stampLabel")}</Label>
              <div className="flex items-center gap-3">
                {stampBase64 && (
                  <img src={stampBase64} alt="" className="h-12 w-12 rounded border object-contain" />
                )}
                <label className="flex h-8 cursor-pointer items-center gap-2 rounded-lg border border-input px-3 text-sm hover:bg-accent">
                  <Upload className="size-4" />
                  {t("uploadButton")}
                  <input
                    type="file"
                    accept="image/*"
                    className="hidden"
                    onChange={(e) => handleFileChange(e, STAMP_MAX_UPLOAD_DIMENSION, setStampBase64)}
                    disabled={!canUpdate}
                  />
                </label>
                {stampBase64 && (
                  <Button type="button" variant="ghost" size="sm" onClick={() => setStampBase64(null)}>
                    {tCommon("remove")}
                  </Button>
                )}
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div className="flex flex-col gap-1">
                  <Label htmlFor="stampWidthPx" className="text-xs text-muted-foreground">
                    {t("widthPxLabel")}
                  </Label>
                  <Input
                    id="stampWidthPx"
                    type="number"
                    min={1}
                    max={255}
                    value={stampWidthPx}
                    onChange={(e) => setStampWidthPx(e.target.value)}
                    disabled={!canUpdate}
                  />
                </div>
                <div className="flex flex-col gap-1">
                  <Label htmlFor="stampHeightPx" className="text-xs text-muted-foreground">
                    {t("heightPxLabel")}
                  </Label>
                  <Input
                    id="stampHeightPx"
                    type="number"
                    min={1}
                    max={255}
                    value={stampHeightPx}
                    onChange={(e) => setStampHeightPx(e.target.value)}
                    disabled={!canUpdate}
                  />
                </div>
              </div>
              <p className="text-xs text-muted-foreground">{t("dimensionHint")}</p>
            </div>

            <div className="flex flex-col gap-2">
              <Label htmlFor="accentColorHex">{t("accentColorLabel")}</Label>
              <div className="flex items-center gap-2">
                <input
                  type="color"
                  value={HEX_COLOR_PATTERN.test(accentColorHex) ? accentColorHex : "#000000"}
                  onChange={(e) => setAccentColorHex(e.target.value)}
                  disabled={!canUpdate}
                  className="h-8 w-10 cursor-pointer rounded border border-input bg-background p-0.5"
                />
                <Input
                  id="accentColorHex"
                  value={accentColorHex}
                  onChange={(e) => setAccentColorHex(e.target.value)}
                  placeholder="#000000"
                  disabled={!canUpdate}
                  className="w-32"
                />
              </div>
            </div>

            <div className="flex flex-col gap-2">
              <Label htmlFor="fontFamily">{t("fontFamilyLabel")}</Label>
              <Select
                value={fontFamily ?? "none"}
                onValueChange={(value) => setFontFamily(value === "none" ? null : value)}
                disabled={!canUpdate}
              >
                <SelectTrigger id="fontFamily" className="w-56">
                  <SelectValue>
                    {(value: string | null) =>
                      value && value !== "none" ? value : t("fontFamilyDefault")
                    }
                  </SelectValue>
                </SelectTrigger>
                <SelectContent alignItemWithTrigger={false}>
                  <SelectItem value="none">{t("fontFamilyDefault")}</SelectItem>
                  {FONT_OPTIONS.map((font) => (
                    <SelectItem key={font} value={font}>
                      {font}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            {saveError && <p className="text-sm text-destructive">{saveError}</p>}
            {saveSuccess && <p className="text-sm text-emerald-600">{t("saveSuccess")}</p>}

            {canUpdate && (
              <Button type="button" onClick={handleSave} disabled={isSaving} className="w-fit">
                {isSaving ? tCommon("processing") : tCommon("save")}
              </Button>
            )}
          </div>

          <div className="flex flex-col gap-2">
            <div className="flex items-center justify-between">
              <Label>{t("previewLabel")}</Label>
              {isPreviewLoading && (
                <span className="text-xs text-muted-foreground">{t("previewUpdating")}</span>
              )}
            </div>
            {previewError && <p className="text-sm text-destructive">{previewError}</p>}

            <ZoomableInvoicePreview
              html={previewHtml}
              heightClassName="h-[500px]"
              emptyLabel={previewError ? t("previewFailed") : t("previewUpdating")}
            />
          </div>
        </div>
      </CardContent>
    </Card>
  );
}