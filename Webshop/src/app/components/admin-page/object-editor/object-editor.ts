import { Component, inject, input, OnInit } from '@angular/core';
import { Book } from '../../../models/book.model';
import { Publisher } from '../../../models/publisher.model';
import { Genre } from '../../../models/genre.model';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';
import { BookService } from '../../../services/book-service';
import { PublisherService } from '../../../services/publisher-service';
import { GenreService } from '../../../services/genre-service';

@Component({
  selector: 'app-object-editor',
  imports: [ReactiveFormsModule],
  templateUrl: './object-editor.html',
  styleUrl: './object-editor.css',
})
export class ObjectEditor implements OnInit{
  selectedType = input.required<"book" | "publisher" | "genre">()
  id = input.required<number>()
  selectedObject!: Book | Publisher | Genre
  bookService = inject(BookService)
  publisherService = inject(PublisherService)
  genreService = inject(GenreService)
  editorForm!: FormGroup

  ngOnInit(): void {
    if (this.selectedType() == "book") {
      this.bookService.getBookById(this.id()).subscribe({
        next: response => {
          this.selectedObject = response
        },
        complete: () => {

        }
      })
    } else if (this.selectedType() == "publisher") {
      this.publisherService.getPublisherById(this.id()).subscribe({
        next: (response: Book | Publisher | Genre) => {
          this.selectedObject = response
        },
        complete: () => {

        }
      })
    } else if (this.selectedType() == "genre") {
      this.genreService.getGenreById(this.id()).subscribe({
        next: (response: Book | Publisher | Genre) => {
          this.selectedObject = response
        },
        complete: () => {
          this.editorForm = new FormGroup({

          })
        }
      })
    }
  }
}
