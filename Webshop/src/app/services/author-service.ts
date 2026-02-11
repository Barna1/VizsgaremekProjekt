import { HttpClient } from "@angular/common/http";
import { inject, Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Author } from "../models/author.model";

@Injectable({
    providedIn: 'root'
})

export class AuthorService {
    private baseUrl = ""
    private http = inject(HttpClient)

    getAllAuthor(): Observable<Author[]> {
        return this.http.get<Author[]>("")
    }

    addAuthor(newAuthor: Author): Observable<Author> {
        return this.http.post<Author>("", newAuthor)
    }

    deleteAuthor(id: number) {
        return this.http.delete("")
    }

    updateAuthor(updateAuthor: Author): Observable<Author> {
        return this.http.put<Author>("", updateAuthor)
    }

}
