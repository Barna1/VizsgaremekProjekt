import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Genre } from '../models/genre.model';

@Injectable({
  providedIn: 'root',
})
export class GenreService {
  private http = inject(HttpClient)

  getAllGenre(): Observable<Genre[]> {
    return this.http.get<Genre[]>("")
  }

  addGenre(newGenre: Genre) {
    return this.http.post("", newGenre)
  }

  updateGenre(updatedGenre: Genre) {
    return this.http.put("", updatedGenre)
  }

  deleteGenre(id: number) {
    return this.http.delete("")
  }
}
