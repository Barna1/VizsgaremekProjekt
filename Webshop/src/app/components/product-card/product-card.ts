import { Component, inject, input } from '@angular/core';
import { Book } from '../../models/book.model';
import { Router } from '@angular/router';

@Component({
  selector: 'app-product-card',
  imports: [],
  templateUrl: './product-card.html',
  styleUrl: './product-card.css',
})
export class ProductCard {
  private router = inject(Router)
  productDetail = input.required<Book>()

  navigate() {
    console.log(this.productDetail())
    this.router.navigate(["productDetail", this.productDetail()?.id])
  }
}
