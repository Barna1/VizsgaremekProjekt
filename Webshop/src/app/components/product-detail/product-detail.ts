import { UserService } from './../../services/user-service';
import { Component, inject, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Book } from '../../models/book.model';
import { BookService } from '../../services/book-service';
import { ReviewCard } from './review-card/review-card';
import { BasketService } from '../../services/basket-service';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-product-detail',
  imports: [ReviewCard, NgClass],
  templateUrl: './product-detail.html',
  styleUrl: './product-detail.css',
})
export class ProductDetail implements OnInit{
  private bookService = inject(BookService)
  private basketService = inject(BasketService)
  private userService = inject(UserService)
  private route = inject(ActivatedRoute)
  selectedBook!: Book
  showAlert = false;
  type: 'success' | 'danger' = 'success';
  message = '';


  ngOnInit(): void {
    this.route.params.subscribe({
      next: param => {
        console.log(param["id"])
        if (+param["id"] != null) {
          this.bookService.getBookById(+param["id"]).subscribe({
            next: response => this.selectedBook = response,
            error: error => {
              console.log(error.status)
            }
          })
        }
      }
    })
  }

  addToCart() {
    console.log("Add to Cart")
      this.basketService.addProductToBasket(this.userService.loggedUser?.id!, {productId: this.selectedBook.id!, amount: 1}).subscribe({

        next: res => {
      this.type = 'success';
      this.message = 'Termék hozzáadva a kosárhoz!';
      this.showAlert = true;

    },

    error: err => {
      this.type = 'danger';
      this.message = 'Nem sikerült kosárba rakni!';
      this.showAlert = true;
    }

      });
      }
      
      
  }
