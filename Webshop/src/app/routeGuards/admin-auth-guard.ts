import { inject, Injectable } from "@angular/core";
import { CanMatch, GuardResult, MaybeAsync, RedirectCommand, Route, Router, UrlSegment } from "@angular/router";
import { UserService } from "../services/user-service";

@Injectable({
    providedIn: "root"
})

export class AdminAuthGuard implements CanMatch {
    userService = inject(UserService)
    router = inject(Router)

    canMatch(route: Route, segments: UrlSegment[]) {
        if (this.userService.loggedUser?.role?.name == "ROLE_admin") {
            return true
        }

        return new RedirectCommand(this.router.parseUrl("/unauthorized"))
    }
}
