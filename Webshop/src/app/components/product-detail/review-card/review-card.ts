import { Component, input } from '@angular/core';
import { Review } from '../../../models/review.model';

@Component({
  selector: 'app-review-card',
  imports: [],
  templateUrl: './review-card.html',
  styleUrl: './review-card.scss',
})
export class ReviewCard {
  reviewDetail = input.required<Review>()


}
