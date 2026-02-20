import { Component, inject, OnInit } from '@angular/core';
import { BookService } from '../../services/book-service';
import { Book } from '../../models/book.model';
import { ProductCard } from '../product-card/product-card';

@Component({
  selector: 'app-product-list',
  imports: [ProductCard],
  templateUrl: './product-list.html',
  styleUrl: './product-list.css',
})
export class ProductList implements OnInit{
  bookService = inject(BookService)
  bookList: Book[] = []
  pageNumber = 0;
  isAsc: boolean = false
  sortType: string = "id"
  isError: boolean = false
  availablePages: number[] = []

  ngOnInit(): void {
    this.getBookPage()
  }

  getBookPage() {
    this.bookService.getBooksPage(this.pageNumber, this.sortType, this.isAsc).subscribe({
      next: response => {
        this.bookList = response.body as Book[]
        const pageNumber: number = +response.headers.get("totalpage")!
        this.availablePages = Array(pageNumber).fill(1).map((x,i)=>i+1)
      },
      error: error => this.isError = true
    })
  }

  getRows(): Book[][] {
    const rows: Book[][] = []
    for (let i: number = 0; i< 12; i+=3) {
      const row: Book[] = []
      for (let j = i; j < i+3; j++) {
        if (this.bookList[j] != undefined) {
          row.push(this.bookList[j])
        }
      }
      rows.push(row)
    }

    return rows;
  }

  changePageWithArrows(isForward: boolean) {
    if ((this.pageNumber - 1 >= 0 && !isForward) || (this.pageNumber + 1 < this.availablePages.length && isForward)) {
      this.pageNumber += isForward ? 1 : -1;
      this.getBookPage()
    }
  }
}