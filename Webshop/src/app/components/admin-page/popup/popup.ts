import { Component, inject, input, OnInit, output } from '@angular/core';
import { BookService } from '../../../services/book-service';
import { GenreService } from '../../../services/genre-service';
import { PublisherService } from '../../../services/publisher-service';
import { ObjectEditor } from '../object-editor/object-editor';
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
  selectedIdForDelete: number | null = null;
  selectedIdForEdit: number | null = null

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
      this.bookService.getBooksWithoutPaginator().subscribe({
        next: response => {
          this.cardList = response.map((b) => {
            return {id: b.id, name: b.title}
          })
        }
      })
    } else if (this.selectedType() == "publisher") {
      this.publisherService.getAllPublisher().subscribe({
        next: response => {
          this.cardList = response.map((p) => {
            return {id: p.id, name: p.name}
          })
        }
      })
    }
  }

  deleteObject() {
    if (this.selectedType() == "genre") {
      this.deleteGenre
    }
  }

  deleteGenre() {
    this.genreService.deleteGenre(this.selectedIdForDelete!).subscribe({
      next: response => {
        this.cardList = this.cardList.filter(c => c.id != this.selectedIdForDelete!)
      },
      complete: () => {
        this.selectedIdForDelete = null
      }
    })
  }

  deleteBook() {
    this.bookService.deleteBook(this.selectedIdForDelete!).subscribe({
      next: response => {
        this.cardList = this.cardList.filter(c => c.id != this.selectedIdForDelete!)
      },
      complete: () => {
        this.selectedIdForDelete = null
      }
    })
  }

  deletePublisher() {
    this.publisherService.deletePublisher(this.selectedIdForDelete!).subscribe({
      next: response => {
        this.cardList = this.cardList.filter(c => c.id != this.selectedIdForDelete!)
      },
      complete: () => {
        this.selectedIdForDelete = null
      }
    })
  }
}
