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
        <SidebarInset>
          <div className="p-4">
            <SidebarTrigger />
          </div>
          {children}
        </SidebarInset>
      </SidebarProvider>
    </PermissionProvider>
  );
}
