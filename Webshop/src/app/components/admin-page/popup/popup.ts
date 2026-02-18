import { Component, inject, input, OnInit, output } from '@angular/core';
import { GenreService } from '../../../services/genre-service';
import { BookService } from '../../../services/book-service';
import { PublisherService } from '../../../services/publisher-service';
import { ObjectEditor } from '../object-editor/object-editor';
import { Genre } from '../../../models/genre.model';
import { Publisher } from '../../../models/publisher.model';
import { Book } from '../../../models/book.model';
import { ListCard } from './list-card/list-card';

@Component({
  selector: 'app-popup',
  imports: [ObjectEditor, ListCard],
  templateUrl: './popup.html',
  styleUrl: './popup.css',
})

export class Popup implements OnInit {
  close = output()
  selectedType = input.required<"genre" | "book" | "publisher">()
  genreService = inject(GenreService)
  bookService = inject(BookService)
  publisherService = inject(PublisherService)
  showForm: boolean = false
  showDelete: boolean = false
  cardList: {id: number, name: string}[] = []

  ngOnInit(): void {
    if (this.selectedType() == "genre") {
      this.genreService.getAllGenre().subscribe({
        next: response => {
          this.cardList = response.map((g)=> {
            return {id: g.id, name: g.name}
          });
        }
      })
    } else if (this.selectedType() == "book") {

    } else if (this.selectedType() == "publisher") {

    }
  }

  deleteGenre(id: number) {
    this.genreService.deleteGenre(id).subscribe({
      next: response => {

      }
    })
  }

  deleteBook(id: number) {
    this.bookService.deleteBook(id).subscribe({
      next: response => {

      }
    })
  }

  deletePublisher(id: number) {
    this.publisherService.deletePublisher(id).subscribe({
      next: response => {
        
      }
    })
  }
}
