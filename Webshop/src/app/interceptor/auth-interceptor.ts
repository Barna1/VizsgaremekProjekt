import { HttpEvent, HttpHandlerFn, HttpRequest } from "@angular/common/http";
import { inject } from "@angular/core";
import { CookieService } from "ngx-cookie-service";
import { Observable } from "rxjs";

export function AuthInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn): Observable<HttpEvent<unknown>> {
  const cookieService = inject(CookieService)

  if (req.url === "http://localhost:8080/user/login") {
    const requestBody = req.body as { username: string, password: string }
    const cloneOfRequest = req.clone({
      headers: req.headers.append("Authorization", "Basic " + btoa(requestBody.username + ":" + requestBody.password))
    })
    return next(cloneOfRequest)

  } else {
    console.log("ASDASDASDASD")
    const cloneOfRequest = req.clone({
      headers: req.headers
        .append("Authorization", `Bearer ${cookieService.get("jwt")}`)
        .append("refreshToken", cookieService.get("refreshToken"))
    })

    console.log(cloneOfRequest)
    return next(cloneOfRequest)
  }
}
