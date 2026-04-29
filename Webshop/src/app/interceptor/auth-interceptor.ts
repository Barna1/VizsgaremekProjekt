import { HttpEvent, HttpHandlerFn, HttpRequest } from "@angular/common/http";
import { inject } from "@angular/core";
import { CookieService } from "ngx-cookie-service";
import { Observable } from "rxjs";

export function AuthInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn): Observable<HttpEvent<unknown>> {
  const cookieService = inject(CookieService)

  if (req.url === "http://localhost:8080/user/login") {
    const requestBody = req.body as { username: string, password: string }

    return next(req.clone({
      setHeaders: {
        Authorization: "Basic " + btoa(requestBody.username + ":" + requestBody.password)
      }
    }))
  }

  const jwt = cookieService.get("jwt")
  const refresh = cookieService.get("refreshToken")

  let headers: any = {}

  if (jwt) {
    headers["Authorization"] = `Bearer ${jwt}`
  }

  if (refresh) {
    headers["refreshToken"] = refresh
  }

  const clone = req.clone({ setHeaders: headers })

  return next(clone)
}