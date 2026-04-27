import { HttpEvent, HttpHandlerFn, HttpRequest } from "@angular/common/http";
import { inject } from "@angular/core";
import { CookieService } from "ngx-cookie-service";
import { Observable } from "rxjs";

export function AuthInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn): Observable<HttpEvent<unknown>> {
  const cookieService = inject(CookieService);
  const jwt = cookieService.get("jwt");

  if (req.url.includes('/user/login') || req.url.includes('/user/register')) {
    return next(req);
  }

  if (jwt) {
    const cloneOfRequest = req.clone({
      setHeaders: {
        Authorization: `Bearer ${jwt}`,
        refreshToken: cookieService.get("refreshToken") || ""
      }
    });
    return next(cloneOfRequest);
  }

  return next(req);
}