import { Component, inject, input, OnInit } from '@angular/core';
import { Book } from '../../../models/book.model';
import { Publisher } from '../../../models/publisher.model';
import { Genre } from '../../../models/genre.model';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { BookService } from '../../../services/book-service';
import { PublisherService } from '../../../services/publisher-service';
import { GenreService } from '../../../services/genre-service';
import { Author } from '../../../models/author.model';
import { AuthorService } from '../../../services/author-service';

@Component({
  selector: 'app-object-editor',
  imports: [ReactiveFormsModule],
  templateUrl: './object-editor.html',
  styleUrl: './object-editor.css',
})
export class ObjectEditor implements OnInit {
  selectedType = input.required<"book" | "publisher" | "genre">()
  id = input.required<number | null>()
  selectedObject!: Book | Publisher | Genre
  bookService = inject(BookService)
  publisherService = inject(PublisherService)
  genreService = inject(GenreService)
  authorService = inject(AuthorService)
  editorForm!: FormGroup

  publishers: Publisher[] = []
  genres: Genre[] = []
  authors: Author[] = []

  ngOnInit(): void {
    if (this.id() != null) {
      if (this.selectedType() == "book") {
        this.bookService.getBookById(this.id()!).subscribe({
          next: response => {
            this.selectedObject = response
          },
          complete: () => {
            this.editorForm = new FormGroup({
              title: new FormControl("", [Validators.required]),
              description: new FormControl("", [Validators.required]),
              coverImg: new FormControl("", [Validators.required]),
              publishingYear: new FormControl("", [Validators.required]),
              ISBN: new FormControl("", [Validators.required]),
              price: new FormControl("", [Validators.required]),
              stockQuantity: new FormControl("", [Validators.required]),
              publisher: new FormControl("", [Validators.required]),
              genres: new FormControl("", [Validators.required]),
              authors: new FormControl("", [Validators.required])
            })
          }
        })
      } else if (this.selectedType() == "publisher") {
        this.publisherService.getPublisherById(this.id()!).subscribe({
          next: response => {
            this.selectedObject = response
          },
          complete: () => {
            this.editorForm = new FormGroup({
              name: new FormControl((this.selectedObject as Publisher).name, [Validators.required]),
              email: new FormControl((this.selectedObject as Publisher).email, [Validators.required, Validators.email]),
              phone: new FormControl((this.selectedObject as Publisher).phone, [Validators.required]),
              isbnSign: new FormControl((this.selectedObject as Publisher).isbnSign, [Validators.required])
            })
          }
        })
      } else if (this.selectedType() == "genre") {
        this.genreService.getGenreById(this.id()!).subscribe({
          next: response => {
            this.selectedObject = response
          },
          complete: () => {
            this.editorForm = new FormGroup({
              name: new FormControl((this.selectedObject as Genre).name, [Validators.required])
            })
          }
        })
      }
    } else {
      if (this.selectedType() == "book") {
        this.editorForm = new FormGroup({
          title: new FormControl("", [Validators.required]),
          description: new FormControl("", [Validators.required]),
          coverImg: new FormControl("", [Validators.required]),
          publishingYear: new FormControl("", [Validators.required]),
          ISBN: new FormControl("", [Validators.required]),
          price: new FormControl("", [Validators.required]),
          stockQuantity: new FormControl("", [Validators.required]),
          publisher: new FormControl("", [Validators.required]),
          genres: new FormControl("", [Validators.required]),
          authors: new FormControl("", [Validators.required])
        })
      } else if (this.selectedType() == "publisher") {
        this.editorForm = new FormGroup({
          name: new FormControl("", [Validators.required]),
          email: new FormControl("", [Validators.required, Validators.email]),
          phone: new FormControl("", [Validators.required]),
          isbnSign: new FormControl("", [Validators.required]),
        })
      } else if (this.selectedType() == "genre") {
        this.editorForm = new FormGroup({
          name: new FormControl("", [Validators.required])
        })
      }
    }

    if (this.selectedType() == "book") {
      this.publisherService.getAllPublisher().subscribe({
        next: response => {
          this.publishers = response
        }
      })

      this.genreService.getAllGenre().subscribe({
        next: response => {
          this.genres = response
        }
      })

      this.authorService.getAllAuthor().subscribe({
        next: response => {
          this.authors = response
        }
      })
    }
  }
}
