"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { useTranslations } from "next-intl";
import { Maximize2, Minus, Plus, RotateCcw } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogTitle } from "@/components/ui/dialog";

const NATURAL_WIDTH = 816;
const FALLBACK_HEIGHT = 1202;
const MIN_ZOOM = 0.2;
const MAX_ZOOM = 3;
const ZOOM_STEP = 0.1;
const HEIGHT_MESSAGE_SOURCE = "invoice-app-preview";

function clampZoom(value: number): number {
  return Math.max(MIN_ZOOM, Math.min(MAX_ZOOM, Number(value.toFixed(2))));
}

const FIT_SAFETY_MARGIN_PX = 1;

function computeFitZoom(containerWidth: number): number {
  if (containerWidth <= 0) {
    return 1;
  }

  const usableWidth = Math.max(0, containerWidth - FIT_SAFETY_MARGIN_PX);

  return Math.max(MIN_ZOOM, usableWidth / NATURAL_WIDTH);
}

function withHeightReporter(html: string): string {
  const script = `<script>(function(){function r(){try{var h=document.documentElement.scrollHeight;window.parent.postMessage({source:"${HEIGHT_MESSAGE_SOURCE}",height:h},"*");}catch(e){}}window.addEventListener("load",r);if(window.ResizeObserver){new ResizeObserver(r).observe(document.body);}setTimeout(r,50);setTimeout(r,300);setTimeout(r,800);})();</script>`;

  if (html.includes("</body>")) {
    return html.replace("</body>", `${script}</body>`);
  }

  return html + script;
}

interface ScaledFrameProps {
  html: string | null;
  zoom: number;
  contentHeight: number;
  measureRef: React.RefObject<HTMLDivElement | null>;
  emptyLabel: string;
}

function ScaledFrame({ html, zoom, contentHeight, measureRef, emptyLabel }: ScaledFrameProps) {
  return (
    <div
      ref={measureRef}
      className="h-full min-h-0 w-full min-w-0 overflow-x-auto overflow-y-scroll rounded-md border bg-muted"
    >
      {html ? (
        <div className="mx-auto" style={{ width: NATURAL_WIDTH * zoom, height: contentHeight * zoom }}>
          <div style={{ width: NATURAL_WIDTH, transform: `scale(${zoom})`, transformOrigin: "top left" }}>
            <iframe
              srcDoc={html}
              className="bg-white"
              style={{ width: NATURAL_WIDTH, height: contentHeight, border: 0 }}
              sandbox="allow-scripts"
            />
          </div>
        </div>
      ) : (
        <div className="flex h-full w-full items-center justify-center text-sm text-muted-foreground">
          {emptyLabel}
        </div>
      )}
    </div>
  );
}

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
  const t = useTranslations("invoiceCustomization");

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

interface FullscreenPreviewBodyProps {
  html: string;
  contentHeight: number;
}

function FullscreenPreviewBody({ html, contentHeight }: FullscreenPreviewBodyProps) {
  const [fullscreenZoom, setFullscreenZoom] = useState(1);
  const fullscreenMeasureRef = useRef<HTMLDivElement>(null);

  useFitOnMount(fullscreenMeasureRef, setFullscreenZoom);

  function handleFullscreenFit() {
    const el = fullscreenMeasureRef.current;

    if (el) {
      setFullscreenZoom(computeFitZoom(el.clientWidth));
    }
  }

  return (
    <div className="flex min-h-0 min-w-0 flex-1 flex-col gap-2">
      <ZoomControls
        zoom={fullscreenZoom}
        onZoomIn={() => setFullscreenZoom((z) => clampZoom(z + ZOOM_STEP))}
        onZoomOut={() => setFullscreenZoom((z) => clampZoom(z - ZOOM_STEP))}
        onFit={handleFullscreenFit}
      />
      <div className="min-h-0 min-w-0 flex-1">
        <ScaledFrame
          html={html}
          zoom={fullscreenZoom}
          contentHeight={contentHeight}
          measureRef={fullscreenMeasureRef}
          emptyLabel=""
        />
      </div>
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
  const t = useTranslations("invoiceCustomization");
  const [zoom, setZoom] = useState(1);
  const [fullscreenOpen, setFullscreenOpen] = useState(false);
  const [contentHeight, setContentHeight] = useState(FALLBACK_HEIGHT);

  const measureRef = useRef<HTMLDivElement>(null);

  const reportedHtml = useMemo(() => (html ? withHeightReporter(html) : null), [html]);

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

  function handleFit() {
    const el = measureRef.current;

    if (el) {
      setZoom(computeFitZoom(el.clientWidth));
    }
  }

  return (
    <div className="flex h-full min-w-0 flex-col gap-2">
      <ZoomControls
        zoom={zoom}
        onZoomIn={() => setZoom((z) => clampZoom(z + ZOOM_STEP))}
        onZoomOut={() => setZoom((z) => clampZoom(z - ZOOM_STEP))}
        onFit={handleFit}
        onFullscreen={reportedHtml ? () => setFullscreenOpen(true) : undefined}
      />

      <div className={`${heightClassName} min-h-0 min-w-0`}>
        <ScaledFrame
          html={reportedHtml}
          zoom={zoom}
          contentHeight={contentHeight}
          measureRef={measureRef}
          emptyLabel={emptyLabel}
        />
      </div>

      <Dialog open={fullscreenOpen} onOpenChange={setFullscreenOpen}>
        <DialogContent
          className="flex min-w-0 flex-col gap-2"
          style={{ width: "95vw", maxWidth: "95vw", height: "90vh" }}
        >
          <DialogTitle>{t("previewLabel")}</DialogTitle>
          {fullscreenOpen && reportedHtml && (
            <FullscreenPreviewBody html={reportedHtml} contentHeight={contentHeight} />
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}