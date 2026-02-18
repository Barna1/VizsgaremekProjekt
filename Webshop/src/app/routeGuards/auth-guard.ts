import { UserService } from './../services/user-service';
import { inject, Injectable } from "@angular/core";
import { CanMatch, RedirectCommand, Route, Router, UrlSegment } from "@angular/router";

@Injectable({
    providedIn: "root"
})

export class AuthGuard implements CanMatch {
    userService = inject(UserService)
    router = inject(Router)

    canMatch(route: Route, segments: UrlSegment[]) {
        if (this.userService.loggedUser != null) {
            return true
        }

        return new RedirectCommand(this.router.parseUrl("/unauthorized"))
    }
}
