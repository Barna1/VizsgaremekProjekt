import { Book } from './../models/book.model';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class BookService {
  private http = inject(HttpClient)
  private baseUrl: string = "http://localhost:8080/book"

  getBookById(id: number): Observable<Book> {
    return this.http.get<Book>(`${this.baseUrl}/${id}`)
  }

  getBooksByGenre(genreId: number, page: number) {
    return this.http.get(`${this.baseUrl}/genre/${genreId}?page=${page}&size=9`, {observe: "response"})
  }

  getBookByPublisher(publisherId: number): Observable<Book[]> {
    return this.http.get<Book[]>(`${this.baseUrl}/publisher/${publisherId}`)
  }

  getMostSuccessFullyBooks():Observable<Book[]> {
    return this.http.get<Book[]>(`${this.baseUrl}/successfully`)
  }

  getBooksPage(page: number, sortType: string, isAsc: boolean) {
    return this.http.get(`${this.baseUrl}?page=${page}&size=9&sort=${sortType},${isAsc ? "asc" : "desc"}`, {observe: "response"})
  }

  addBook(newBook: Book) {
    return this.http.post("", newBook)
  }

  updateBook(updatedBook: Book) {
    return this.http.put("", updatedBook)
  }

  deleteBook(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }

  getBooksWithoutPaginator(): Observable<Book[]> {
    return this.http.get<Book[]>(this.baseUrl)
  }

  getBookByGenre(genreId: number, page: number, sortType: string, isAsc: boolean) {
    return this.http.get(`${this.baseUrl}/genre/${genreId}?page=${page}&size=9&sort=${sortType},${isAsc ? "asc" : "desc"}`, {observe: "response"})
  }
}
