import { Component, inject, OnInit } from '@angular/core';
import { PublisherService } from '../../services/publisher-service';
import { Publisher } from '../../models/publisher.model';
import { BookService } from '../../services/book-service';
import { Book } from '../../models/book.model';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-publisher-list',
  imports: [RouterModule],
  templateUrl: './publisher-list.html',
  styleUrl: './publisher-list.css',
})
export class PublisherList implements OnInit{
  publisherService = inject(PublisherService)
  bookService = inject(BookService)
  publishers: Publisher[] = []
  selectedPublisher: Publisher | null = null
  bookList: Book[] = []

  ngOnInit(): void {
    this.publisherService.getAllPublisher().subscribe({
      next: response => this.publishers = response
    })
  }

  selectPublisher(selectedPublisher: Publisher) {
    this.selectedPublisher = selectedPublisher
    this.bookService.getBooksByPublisher(selectedPublisher.id).subscribe({
      next: response => this.bookList = response
    })
  }
}
