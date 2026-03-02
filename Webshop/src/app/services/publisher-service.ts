import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Publisher } from '../models/publisher.model';

@Injectable({
  providedIn: 'root',
})
export class PublisherService {
  http = inject(HttpClient)
  baseUrl = "http://localhost:8080/publisher"

  getAllPublisher(): Observable<Publisher[]> {
    return this.http.get<Publisher[]>(this.baseUrl)
  }

  getPublisherById(id: number): Observable<Publisher> {
    return this.http.get<Publisher>(`${this.baseUrl}/${id}`)
  }

  deletePublisher(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }

  addPublisher(newPublisher: Publisher): Observable<Publisher> {
    return this.http.post<Publisher>(this.baseUrl, newPublisher)
  }

  updatePublisher(updatedPublisher: Publisher) {
    return this.http.put<Publisher>(this.baseUrl, updatedPublisher)
  }
}
