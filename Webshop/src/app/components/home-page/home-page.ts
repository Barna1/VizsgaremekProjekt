import { BookService } from './../../services/book-service';
import { Component, inject, OnInit } from '@angular/core';
import { ProductCard } from '../product-card/product-card';
import { Book } from '../../models/book.model';

@Component({
  selector: 'app-home-page',
  imports: [ProductCard],
  templateUrl: './home-page.html',
  styleUrl: './home-page.css',
})
export class HomePage implements OnInit {
  bookService = inject(BookService)
  successfullyBooks: Book[] = []


  ngOnInit(): void {
      this.bookService.getMostSuccessFullyBooks().subscribe({
        next: response => {
          console.log(response);
          this.successfullyBooks = response
        }
      })
  }
}
