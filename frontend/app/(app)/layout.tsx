import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { decodeJwt, isTokenExpired, TOKEN_COOKIE_NAME } from "@/lib/jwt";
import { SidebarProvider, SidebarInset, SidebarTrigger } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/app-sidebar";
import { PermissionProvider } from "@/contexts/PermissionContext";

export default async function AppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const cookieStore = await cookies();
  const token = cookieStore.get(TOKEN_COOKIE_NAME)?.value;
  const decoded = token ? decodeJwt(token) : null;

  if (!decoded || isTokenExpired(decoded.exp)) {
    redirect("/login");
  }

  return (
    <PermissionProvider>
      <SidebarProvider>
        <AppSidebar />
        <SidebarInset className="min-w-0">
          <div className="p-4">
            <SidebarTrigger />
          </div>
          <div className="min-w-0 px-[clamp(0.10rem,8vw,9rem)] pt-4 pb-8">{children}</div>
        </SidebarInset>
      </SidebarProvider>
    </PermissionProvider>
  );
}