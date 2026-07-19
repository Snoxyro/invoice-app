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
import type { PagedResult } from "@/lib/paging";

interface UserResponse {
  userId: number;
  userName: string;
  profileId: number | null;
  profileName: string | null;
  createdDate: string;
  updatedDate: string | null;
}

interface ProfileOption {
  profileId: number;
  name: string;
}

interface UserFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  user: UserResponse | null;
  onSuccess: (user: UserResponse) => void;
}

export function UserFormDialog({ open, onOpenChange, user, onSuccess }: UserFormDialogProps) {
  const t = useTranslations("users");
  const tCommon = useTranslations("common");
  const tErrors = useTranslations("errors");

  const isEditMode = user !== null;

  const [userName, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const [profileId, setProfileId] = useState<number | null>(null);
  const [profiles, setProfiles] = useState<ProfileOption[]>([]);
  const [isProfilesLoading, setIsProfilesLoading] = useState(true);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (open) {
      setUserName(user?.userName ?? "");
      setProfileId(user?.profileId ?? null);
      setPassword("");
      setError(null);
    }
  }, [open, user]);

  useEffect(() => {
    if (!open) {
      return;
    }

    let isCancelled = false;

    async function loadProfiles() {
      setIsProfilesLoading(true);

      try {
        const result = await apiFetch<PagedResult<ProfileOption>>("/api/Profiles?pageSize=100");

        if (!isCancelled) {
          setProfiles(result.items);
        }
      } finally {
        if (!isCancelled) {
          setIsProfilesLoading(false);
        }
      }
    }

    loadProfiles();

    return () => {
      isCancelled = true;
    };
  }, [open]);

  function handleProfileChange(value: string | null) {
    if (value) {
      setProfileId(Number(value));
    }
  }

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    try {
      let result: UserResponse;

      if (isEditMode) {
        result = await apiFetch<UserResponse>(`/api/Users/${user.userId}`, {
          method: "PUT",
          body: JSON.stringify({
            userName,
            profileId,
            newPassword: password ? password : null,
          }),
        });
      } else {
        result = await apiFetch<UserResponse>("/api/Users", {
          method: "POST",
          body: JSON.stringify({ userName, password, profileId }),
        });
      }

      onSuccess(result);
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
            {isEditMode && <p className="text-xs text-muted-foreground">{t("newPasswordHint")}</p>}
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="profile-select">{t("columnProfile")}</Label>
            <Select
              value={profileId !== null ? String(profileId) : null}
              onValueChange={handleProfileChange}
              disabled={isProfilesLoading}
            >
              <SelectTrigger id="profile-select" className="w-full">
                <SelectValue>
                  {(value: string | null) =>
                    profiles.find((p) => String(p.profileId) === value)?.name ?? ""
                  }
                </SelectValue>
              </SelectTrigger>
              <SelectContent alignItemWithTrigger={false}>
                {profiles.map((p) => (
                  <SelectItem key={p.profileId} value={String(p.profileId)}>
                    {p.name}
                  </SelectItem>
                ))}
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
            <Button type="submit" disabled={isSubmitting || profileId === null}>
              {isSubmitting ? tCommon("processing") : tCommon("save")}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
