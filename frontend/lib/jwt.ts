export interface DecodedToken {
  userId: number;
  userName: string;
  role: "Admin" | "Firm";
  exp: number;
}

export const TOKEN_COOKIE_NAME = "invoiceapp_token";

const CLAIM_NAME_IDENTIFIER = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier";
const CLAIM_NAME = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name";
const CLAIM_ROLE = "http://schemas.microsoft.com/ws/2008/06/identity/claims/role";

function base64UrlDecode(input: string): string {
  let base64 = input.replace(/-/g, "+").replace(/_/g, "/");

  while (base64.length % 4 !== 0) {
    base64 += "=";
  }

  const binaryString = atob(base64);
  const bytes = Uint8Array.from(binaryString, (char) => char.charCodeAt(0));

  return new TextDecoder("utf-8").decode(bytes);
}

export function decodeJwt(token: string): DecodedToken | null {
  try {
    const payloadSegment = token.split(".")[1];
    const json = JSON.parse(base64UrlDecode(payloadSegment));

    return {
      userId: Number(json[CLAIM_NAME_IDENTIFIER]),
      userName: json[CLAIM_NAME],
      role: json[CLAIM_ROLE],
      exp: json.exp,
    };
  } catch {
    return null;
  }
}

export function isTokenExpired(exp: number): boolean {
  return Date.now() >= exp * 1000;
}