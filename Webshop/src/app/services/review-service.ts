import { HttpClient } from "@angular/common/http";
import { inject, Injectable } from "@angular/core";
import { Review } from "../models/review.model";

@Injectable({
    providedIn: 'root'
})

export class ReviewService {
    http = inject(HttpClient)

    addReview(newReview: Review) {
        return this.http.post("", newReview)
    }

    updateReview(updateReview: Review) {
        return this.http.post("", updateReview)
    }

    deleteReview(id: number) {
        return this.http.delete("")
    }
}
