import { inject, Injectable } from '@angular/core';
import { CanMatch, RedirectCommand, Route, Router, UrlSegment } from '@angular/router';
import { UserService } from '../services/user-service';
@Injectable({
  providedIn: "root"
})
export class AuthenticationGuard implements CanMatch {
  userService = inject(UserService)
  router = inject(Router)

  canMatch(route: Route, segments: UrlSegment[]) {
    if (this.userService.loggedUser != null) {
      return true
    }

    return new RedirectCommand(this.router.parseUrl("/unauthorized"))
  }
}
