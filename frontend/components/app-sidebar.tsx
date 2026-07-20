"use client";

import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import { useTranslations } from "next-intl";
import { Building, Building2, LayoutDashboard, LogOut, Receipt, Settings, ShieldCheck, Users } from "lucide-react";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import { NameAvatar } from "@/components/name-avatar";
import { useAuth } from "@/contexts/AuthContext";
import { usePermissions } from "@/contexts/PermissionContext";

interface NavItem {
  href: string;
  label: string;
  icon: typeof Building2;
}

const menuButtonClassName = "h-10 gap-3 text-base [&_svg]:size-5";

export function AppSidebar() {
  const { user, logout } = useAuth();
  const { hasPermission, profileName } = usePermissions();
  const pathname = usePathname();
  const t = useTranslations("nav");

  const adminItems: NavItem[] = [{ href: "/admin/firms", label: t("firms"), icon: Building }];

  const firmItems: NavItem[] = [
    hasPermission("Users", "Read") ? { href: "/users", label: t("users"), icon: Users } : null,
    hasPermission("Customers", "Read")
      ? { href: "/customers", label: t("customers"), icon: Building2 }
      : null,
    hasPermission("Invoices", "Read")
      ? { href: "/invoices", label: t("invoices"), icon: Receipt }
      : null,
    hasPermission("Profiles", "Read")
      ? { href: "/profiles", label: t("profiles"), icon: ShieldCheck }
      : null,
  ].filter((item): item is NavItem => item !== null);

  const items = user?.role === "Admin" ? adminItems : firmItems;

  return (
    <Sidebar collapsible="icon">
      <SidebarHeader>
        <div className="flex items-center gap-2 px-2 py-1">
          <Image src="/logo.svg" alt="" width={28} height={28} className="shrink-0 rounded-md" />
          <span className="text-base font-semibold group-data-[collapsible=icon]:hidden">
            Invoice App
          </span>
        </div>
      </SidebarHeader>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>{t("menu")}</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              <SidebarMenuItem>
                <SidebarMenuButton
                  render={<Link href="/" />}
                  isActive={pathname === "/"}
                  tooltip={t("home")}
                  className={menuButtonClassName}
                >
                  <LayoutDashboard />
                  <span>{t("home")}</span>
                </SidebarMenuButton>
              </SidebarMenuItem>
              {items.map((item) => (
                <SidebarMenuItem key={item.href}>
                  <SidebarMenuButton
                    render={<Link href={item.href} />}
                    isActive={pathname.startsWith(item.href)}
                    tooltip={item.label}
                    className={menuButtonClassName}
                  >
                    <item.icon />
                    <span>{item.label}</span>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
      <SidebarFooter>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton
              render={<Link href="/settings" />}
              isActive={pathname === "/settings"}
              tooltip={t("settings")}
              className={menuButtonClassName}
            >
              <Settings />
              <span>{t("settings")}</span>
            </SidebarMenuButton>
          </SidebarMenuItem>
          <SidebarMenuItem>
            <SidebarMenuButton onClick={logout} tooltip={t("logout")} className={menuButtonClassName}>
              <LogOut />
              <span>{t("logout")}</span>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
        {user && (
          <div className="flex items-center gap-2 border-t border-sidebar-border px-2 pt-3">
            <NameAvatar name={user.userName} />
            <div className="flex min-w-0 flex-col group-data-[collapsible=icon]:hidden">
              <span className="truncate text-sm font-medium text-sidebar-foreground">
                {user.userName}
              </span>
              {profileName && (
                <span className="truncate text-xs text-sidebar-foreground/60">{profileName}</span>
              )}
            </div>
          </div>
        )}
      </SidebarFooter>
    </Sidebar>
  );
}