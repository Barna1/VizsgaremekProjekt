import { HttpEvent, HttpEventType, HttpHandlerFn, HttpRequest } from "@angular/common/http";
import { inject } from "@angular/core";
import { CookieService } from "ngx-cookie-service";
import { Observable, tap } from "rxjs";

export function CookieSetterInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn): Observable<HttpEvent<unknown>> {
  const cookieService = inject(CookieService);

  return next(req).pipe(
    tap((event) => {
      if (event.type === HttpEventType.Response) {
        let jwtToken = event.headers.get("Authorization") || event.headers.get("Bearer") || event.headers.get("bearer");
        const refreshToken = event.headers.get("refreshToken");

        if (jwtToken) {
          if (jwtToken.startsWith('Bearer ')) {
            jwtToken = jwtToken.substring(7);
          }
          
          cookieService.set("jwt", jwtToken);
          console.log("JWT sikeresen mentve a sütibe!");
        }

        if (refreshToken) {
          cookieService.set("refreshToken", refreshToken);
          console.log("Refresh token sikeresen mentve!");
        }
      }
    })
  );
}