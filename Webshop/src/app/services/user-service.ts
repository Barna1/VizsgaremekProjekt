import { inject, Injectable } from '@angular/core';
import { User } from '../models/user.model';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  loggedUser: User | null = null
  private baseUrl: string = "http://localhost:8080/user"
  private http = inject(HttpClient)

  login(username: string, password:string): Observable<User> {
    return this.http.post<User>(`${this.baseUrl}/login`, {username: username, password: password})
  }

  register(newUser: User) {
    return this.http.post(`${this.baseUrl}/register`, newUser)
  }

  update(id: number, body: {username: string, email: string}): Observable<User> {
    return this.http.patch<User>(`${this.baseUrl}/${id}`, body)
  }

  deleteUser(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }
}
