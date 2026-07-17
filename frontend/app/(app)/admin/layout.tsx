import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { decodeJwt, TOKEN_COOKIE_NAME } from "@/lib/jwt";

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const cookieStore = await cookies();
  const token = cookieStore.get(TOKEN_COOKIE_NAME)?.value;
  const decoded = token ? decodeJwt(token) : null;

  if (!decoded || decoded.role !== "Admin") {
    redirect("/");
  }

  return <>{children}</>;
}