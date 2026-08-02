"use client";

import { useEffect, useRef, useState } from "react";
import { useTranslations } from "next-intl";
import { Maximize2, Minus, Plus, RotateCcw } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogTitle } from "@/components/ui/dialog";

const NATURAL_WIDTH = 850;
// Gerçek yükseklik iframe'den postMessage ile ölçülene kadar kullanılan başlangıç
// tahmini — A4 oranına yakın (850 * 297/210 ≈ 1202), rastgele büyük bir değer değil.
const FALLBACK_HEIGHT = 1202;
const MIN_ZOOM = 0.2;
const MAX_ZOOM = 1.5;
const ZOOM_STEP = 0.1;
const HEIGHT_MESSAGE_SOURCE = "invoice-app-preview";

function clampZoom(value: number): number {
  return Math.max(MIN_ZOOM, Math.min(MAX_ZOOM, Number(value.toFixed(2))));
}

function computeFitZoom(containerWidth: number): number {
  if (containerWidth <= 0) {
    return 1;
  }

  return clampZoom(Math.min(1, containerWidth / NATURAL_WIDTH));
}

/**
 * İframe içeriğinin gerçek yüksekliğini ana pencereye postMessage ile bildiren
 * küçük bir betik ekler. `sandbox="allow-scripts"` kullanıyoruz ama
 * `allow-same-origin` KULLANMIYORUZ (iframe'in kendi izole originde kalması
 * için) — bu yüzden ana pencereden `contentDocument`'a doğrudan erişemeyiz.
 * postMessage, sandbox kısıtlamalarını zayıflatmadan yüksekliği öğrenmenin
 * standart yoludur.
 */
function withHeightReporter(html: string): string {
  const script = `<script>(function(){function r(){try{var h=document.documentElement.scrollHeight;window.parent.postMessage({source:"${HEIGHT_MESSAGE_SOURCE}",height:h},"*");}catch(e){}}window.addEventListener("load",r);if(window.ResizeObserver){new ResizeObserver(r).observe(document.body);}setTimeout(r,50);setTimeout(r,300);setTimeout(r,800);})();</script>`;

  if (html.includes("</body>")) {
    return html.replace("</body>", `${script}</body>`);
  }

  return html + script;
}

interface ScaledFrameProps {
  html: string;
  zoom: number;
  contentHeight: number;
  measureRef: React.RefObject<HTMLDivElement | null>;
}

function ScaledFrame({ html, zoom, contentHeight, measureRef }: ScaledFrameProps) {
  return (
    <div ref={measureRef} className="h-full w-full overflow-auto rounded-md border bg-muted">
      <div style={{ width: NATURAL_WIDTH * zoom, height: contentHeight * zoom }}>
        <div style={{ width: NATURAL_WIDTH, transform: `scale(${zoom})`, transformOrigin: "top left" }}>
          <iframe
            srcDoc={html}
            className="bg-white"
            style={{ width: NATURAL_WIDTH, height: contentHeight, border: 0 }}
            sandbox="allow-scripts"
          />
        </div>
      </div>
    </div>
  );
}

/**
 * Bir konteynerin genişliğine göre yakınlaştırma seviyesini bir kere hesaplar.
 * Bilinçli olarak sürekli izlemiyor (ResizeObserver ile kalıcı takip yapmıyor):
 * içerik yakınlaştırma yüzdesine göre yeniden boyutlandığında konteynerin
 * kaydırma çubuğu görünüp kaybolabiliyor, bu da clientWidth'i değiştirip
 * fonksiyonun kendini tekrar tekrar tetiklemesine (kullanıcının elle
 * ayarladığı zoom'u anında geri almasına) yol açıyordu. Bunun yerine yalnızca
 * mount anında bir kere sığdırma hesaplanıyor; "sığdır" butonu ile istenildiğinde
 * tekrar (tek seferlik) hesaplanabiliyor.
 */
function useFitOnMount(measureRef: React.RefObject<HTMLDivElement | null>, setZoom: (z: number) => void) {
  useEffect(() => {
    const el = measureRef.current;

    if (!el) {
      return;
    }

    let hasFitted = false;

    function applyInitialFit() {
      if (hasFitted || !el) {
        return;
      }

      const width = el.clientWidth;

      if (width > 0) {
        hasFitted = true;
        setZoom(computeFitZoom(width));
        observer.disconnect();
      }
    }

    const observer = new ResizeObserver(applyInitialFit);
    observer.observe(el);
    applyInitialFit();

    return () => observer.disconnect();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
}

interface ZoomControlsProps {
  zoom: number;
  onZoomIn: () => void;
  onZoomOut: () => void;
  onFit: () => void;
  onFullscreen?: () => void;
}

function ZoomControls({ zoom, onZoomIn, onZoomOut, onFit, onFullscreen }: ZoomControlsProps) {
  const t = useTranslations("invoiceSettings");

  return (
    <div className="flex shrink-0 items-center gap-1">
      <Button type="button" variant="outline" size="icon-sm" onClick={onZoomOut} title={t("zoomOutButton")}>
        <Minus />
      </Button>
      <span className="w-12 text-center text-xs text-muted-foreground">{Math.round(zoom * 100)}%</span>
      <Button type="button" variant="outline" size="icon-sm" onClick={onZoomIn} title={t("zoomInButton")}>
        <Plus />
      </Button>
      <Button type="button" variant="outline" size="icon-sm" onClick={onFit} title={t("zoomResetButton")}>
        <RotateCcw />
      </Button>
      {onFullscreen && (
        <Button
          type="button"
          variant="outline"
          size="icon-sm"
          className="ml-auto"
          onClick={onFullscreen}
          title={t("fullscreenButton")}
        >
          <Maximize2 />
        </Button>
      )}
    </div>
  );
}

interface ZoomableInvoicePreviewProps {
  html: string | null;
  heightClassName?: string;
  emptyLabel: string;
}

export function ZoomableInvoicePreview({
  html,
  heightClassName = "h-[500px]",
  emptyLabel,
}: ZoomableInvoicePreviewProps) {
  const t = useTranslations("invoiceSettings");
  const [zoom, setZoom] = useState(1);
  const [fullscreenZoom, setFullscreenZoom] = useState(1);
  const [fullscreenOpen, setFullscreenOpen] = useState(false);
  const [contentHeight, setContentHeight] = useState(FALLBACK_HEIGHT);

  const measureRef = useRef<HTMLDivElement>(null);
  const fullscreenMeasureRef = useRef<HTMLDivElement>(null);

  const reportedHtml = html ? withHeightReporter(html) : null;

  useFitOnMount(measureRef, setZoom);

  useEffect(() => {
    setContentHeight(FALLBACK_HEIGHT);

    function handleMessage(event: MessageEvent) {
      if (event.data?.source === HEIGHT_MESSAGE_SOURCE && typeof event.data.height === "number") {
        setContentHeight(Math.max(200, event.data.height));
      }
    }

    window.addEventListener("message", handleMessage);
    return () => window.removeEventListener("message", handleMessage);
  }, [html]);

  useEffect(() => {
    if (!fullscreenOpen) {
      return;
    }

    const el = fullscreenMeasureRef.current;

    if (el) {
      setFullscreenZoom(computeFitZoom(el.clientWidth));
    }
  }, [fullscreenOpen]);

  function handleFit() {
    const el = measureRef.current;

    if (el) {
      setZoom(computeFitZoom(el.clientWidth));
    }
  }

  function handleFullscreenFit() {
    const el = fullscreenMeasureRef.current;

    if (el) {
      setFullscreenZoom(computeFitZoom(el.clientWidth));
    }
  }

  return (
    <div className="flex h-full flex-col gap-2">
      <ZoomControls
        zoom={zoom}
        onZoomIn={() => setZoom((z) => clampZoom(z + ZOOM_STEP))}
        onZoomOut={() => setZoom((z) => clampZoom(z - ZOOM_STEP))}
        onFit={handleFit}
        onFullscreen={reportedHtml ? () => setFullscreenOpen(true) : undefined}
      />

      <div className={heightClassName}>
        {reportedHtml ? (
          <ScaledFrame html={reportedHtml} zoom={zoom} contentHeight={contentHeight} measureRef={measureRef} />
        ) : (
          <div className="flex h-full w-full items-center justify-center rounded-md border bg-muted text-sm text-muted-foreground">
            {emptyLabel}
          </div>
        )}
      </div>

      <Dialog open={fullscreenOpen} onOpenChange={setFullscreenOpen}>
        <DialogContent
          className="flex flex-col gap-2"
          style={{ width: "95vw", maxWidth: "95vw", height: "90vh" }}
        >
          <DialogTitle>{t("previewLabel")}</DialogTitle>
          {reportedHtml && (
            <div className="flex min-h-0 flex-1 flex-col gap-2">
              <ZoomControls
                zoom={fullscreenZoom}
                onZoomIn={() => setFullscreenZoom((z) => clampZoom(z + ZOOM_STEP))}
                onZoomOut={() => setFullscreenZoom((z) => clampZoom(z - ZOOM_STEP))}
                onFit={handleFullscreenFit}
              />
              <div className="min-h-0 flex-1">
                <ScaledFrame
                  html={reportedHtml}
                  zoom={fullscreenZoom}
                  contentHeight={contentHeight}
                  measureRef={fullscreenMeasureRef}
                />
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}