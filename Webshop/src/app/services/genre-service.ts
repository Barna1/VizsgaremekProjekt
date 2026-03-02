import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Genre } from '../models/genre.model';

@Injectable({
  providedIn: 'root',
})
export class GenreService {
  private http = inject(HttpClient)
  baseUrl: string = "http://localhost:8080/genre"

  getAllGenre(): Observable<Genre[]> {
    return this.http.get<Genre[]>(this.baseUrl)
  }

  getGenreById(id: number): Observable<Genre> {
    return this.http.get<Genre>(`${this.baseUrl}/${id}`)
  }

  addGenre(newGenre: Genre):Observable<Genre> {
    return this.http.post<Genre>(this.baseUrl, newGenre)
  }

  updateGenre(updatedGenre: Genre):Observable<Genre> {
    return this.http.put<Genre>(this.baseUrl, updatedGenre)
  }

  deleteGenre(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }
}
