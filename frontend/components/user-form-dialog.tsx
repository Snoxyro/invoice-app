"use client";

import { useEffect, useState, type FormEvent } from "react";
import { useTranslations } from "next-intl";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
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
import { apiFetch } from "@/lib/api";
import { getApiErrorMessage } from "@/lib/apiErrorMessage";

type UserRole = "Admin" | "Firm";

interface UserResponse {
  userId: number;
  userName: string;
  role: UserRole;
  createdDate: string;
  updatedDate: string | null;
}

interface UserFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  user: UserResponse | null;
  onSuccess: () => void;
}

export function UserFormDialog({ open, onOpenChange, user, onSuccess }: UserFormDialogProps) {
  const t = useTranslations("adminUsers");
  const tCommon = useTranslations("common");
  const tRoles = useTranslations("roles");
  const tErrors = useTranslations("errors");

  const isEditMode = user !== null;

  const [userName, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState<UserRole>("Firm");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (open) {
      setUserName(user?.userName ?? "");
      setRole(user?.role ?? "Firm");
      setPassword("");
      setError(null);
    }
  }, [open, user]);

  function handleRoleChange(value: string | null) {
    if (value === "Admin" || value === "Firm") {
      setRole(value);
    }
  }

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    try {
      if (isEditMode) {
        await apiFetch(`/api/Admin/users/${user.userId}`, {
          method: "PUT",
          body: JSON.stringify({
            userName,
            role,
            newPassword: password ? password : null,
          }),
        });
      } else {
        await apiFetch("/api/Admin/users", {
          method: "POST",
          body: JSON.stringify({ userName, password, role }),
        });
      }

      onSuccess();
      onOpenChange(false);
    } catch (err) {
      setError(getApiErrorMessage(err, tErrors, tErrors("UNEXPECTED_ERROR")));
    } finally {
      setIsSubmitting(false);
    }
  }

  function handleOpenChange(next: boolean) {
    if (!isSubmitting) {
      onOpenChange(next);
    }
  }

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{isEditMode ? t("editTitle") : t("createTitle")}</DialogTitle>
          <DialogDescription>
            {isEditMode ? t("editDescription") : t("createDescription")}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="flex flex-col gap-4 px-4">
          <div className="flex flex-col gap-2">
            <Label htmlFor="userName">{t("columnUsername")}</Label>
            <Input
              id="userName"
              value={userName}
              onChange={(e) => setUserName(e.target.value)}
              required
              autoFocus
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="password">
              {isEditMode ? t("newPasswordLabel") : t("passwordLabel")}
            </Label>
            <Input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required={!isEditMode}
            />
            {isEditMode && (
              <p className="text-xs text-muted-foreground">{t("newPasswordHint")}</p>
            )}
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="role-select">{t("columnRole")}</Label>
            <Select value={role} onValueChange={handleRoleChange}>
              <SelectTrigger id="role-select" className="w-full">
                <SelectValue>
                  {(value: string | null) => (value === "Admin" ? tRoles("admin") : tRoles("firm"))}
                </SelectValue>
              </SelectTrigger>
              <SelectContent alignItemWithTrigger={false}>
                <SelectItem value="Admin">{tRoles("admin")}</SelectItem>
                <SelectItem value="Firm">{tRoles("firm")}</SelectItem>
              </SelectContent>
            </Select>
          </div>

          {error && <p className="text-sm text-destructive">{error}</p>}

          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={() => onOpenChange(false)}
              disabled={isSubmitting}
            >
              {tCommon("cancel")}
            </Button>
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting ? tCommon("processing") : tCommon("save")}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}