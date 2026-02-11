import { HttpClient } from "@angular/common/http";
import { inject, Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Publisher } from "../models/publisher.model";

@Injectable({
    providedIn: 'root'
})

export class PublisherService {
    baseUrl ="http://localhost:8080/publisher"
    http = inject(HttpClient)

    getAllPublisher(): Observable<Publisher[]> {
        return this.http.get<Publisher[]>(this.baseUrl)
    }
}
