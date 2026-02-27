import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { Book } from '../models/book.model';

@Injectable({
  providedIn: 'root',
})
export class BookService {
  private baseUrl: string = 'http://localhost:8080/book';
  private http = inject(HttpClient);

  getBookById(id: number): Observable<Book> {
    return this.http.get<Book>(`${this.baseUrl}/${id}`);
  }

  getBooksByGenre(genreId: number): Observable<Book[]> {
    return this.http.get<Book[]>('');
  }

  getBooksByPublisher(publisherId: number): Observable<Book[]> {
    return this.http.get<Book[]>('');
  }

  getMostSuccessFullyBooks(): Observable<Book[]> {
    return this.http.get<Book[]>(`${this.baseUrl}/successfully`);
  }

  getBooksPage(page: number, sortType: string, isAsc: boolean) {
    return this.http.get(
      `${this.baseUrl}?page=${page}&size=9&sort=${sortType},${isAsc ? 'asc' : 'desc'}`, {observe: "response"}
    );
  }

  addBook(newBook: Book) {
    return this.http.post('', newBook);
  }

  updateBook(updatedBook: Book) {
    return this.http.put("", updatedBook)
  }

  deleteBook(id: number) {
    return this.http.delete("")
  }

  getBooksWithoutPaginator(): Observable<Book[]> {
    return this.http.get<Book[]>(this.baseUrl)
  }
}
