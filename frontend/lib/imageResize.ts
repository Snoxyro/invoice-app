const MAX_UPLOAD_BYTES = 2 * 1024 * 1024;

export class ImageTooLargeError extends Error {}

export function resizeImageToBase64(file: File, maxDimension: number): Promise<string> {
  if (file.size > MAX_UPLOAD_BYTES) {
    return Promise.reject(new ImageTooLargeError("FILE_TOO_LARGE"));
  }

  return new Promise((resolve, reject) => {
    const reader = new FileReader();

    reader.onerror = () => reject(reader.error);

    reader.onload = () => {
      const image = new Image();

      image.onerror = () => reject(new Error("IMAGE_LOAD_FAILED"));

      image.onload = () => {
        const scale = Math.min(1, maxDimension / Math.max(image.width, image.height));
        const width = Math.max(1, Math.round(image.width * scale));
        const height = Math.max(1, Math.round(image.height * scale));

        const canvas = document.createElement("canvas");
        canvas.width = width;
        canvas.height = height;

        const context = canvas.getContext("2d");

        if (!context) {
          reject(new Error("CANVAS_UNAVAILABLE"));
          return;
        }

        context.drawImage(image, 0, 0, width, height);
        resolve(canvas.toDataURL("image/png"));
      };

      image.src = reader.result as string;
    };

    reader.readAsDataURL(file);
  });
}
