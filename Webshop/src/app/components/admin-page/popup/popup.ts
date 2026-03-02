import { Component, inject, input, OnInit, output, signal } from '@angular/core';
import { BookService } from '../../../services/book-service';
import { GenreService } from '../../../services/genre-service';
import { PublisherService } from '../../../services/publisher-service';
import { ObjectEditor } from '../object-editor/object-editor';
import { ListCard } from './list-card/list-card';
import { AdminService } from '../../../services/admin-service';
import { Genre } from '../../../models/genre.model';
import { Publisher } from '../../../models/publisher.model';

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
  adminService = inject(AdminService)
  showForm: boolean = false
  showDelete: boolean = false
  cardList: { id: number, name: string }[] = []
  selectedIdForDelete = signal<number | null>(null)
  selectedIdForEdit: number | null = null
  nameForDelete: string = ""

  ngOnInit(): void {
    if (this.selectedType() == "genre") {
      this.genreService.getAllGenre().subscribe({
        next: response => {
          this.cardList = response.map((g) => {
            return { id: g.id!, name: g.name }
          });
        }
      })
    } else if (this.selectedType() == "book") {
      this.bookService.getBooksWithoutPaginator().subscribe({
        next: response => {
          this.cardList = response.map((b) => {
            return { id: b.id, name: b.title }
          })
        }
      })
    } else if (this.selectedType() == "publisher") {
      this.publisherService.getAllPublisher().subscribe({
        next: response => {
          this.cardList = response.map((p) => {
            return { id: p.id!, name: p.name }
          })
        }
      })
    }
  }

  deleteObject() {
    if (this.selectedType() == "genre") {
      this.deleteGenre()
    } else if (this.selectedType() == "publisher") {
      this.deletePublisher()
    } else if (this.selectedType() == "book") {
      this.deleteBook()
    }
  }

  deleteGenre() {
    this.genreService.deleteGenre(this.selectedIdForDelete()!).subscribe({
      next: response => {
        this.cardList = this.cardList.filter(c => c.id != this.selectedIdForDelete()!)
      },
      complete: () => {
        this.selectedIdForDelete.set(null)
        this.showDelete = false;
      }
    })
  }

  deleteBook() {
    this.bookService.deleteBook(this.selectedIdForDelete()!).subscribe({
      next: response => {
        this.cardList = this.cardList.filter(c => c.id != this.selectedIdForDelete()!)
      },
      complete: () => {
        this.selectedIdForDelete.set(null)
        this.showDelete = false;
      }
    })
  }

  deletePublisher() {
    this.publisherService.deletePublisher(this.selectedIdForDelete()!).subscribe({
      next: response => {
        this.cardList = this.cardList.filter(c => c.id != this.selectedIdForDelete()!)
      },
      complete: () => {
        this.selectedIdForDelete.set(null)
        this.showDelete = false;
      }
    })
  }

  handleEventButton(eventType: "showForm" | "sendSave", id: number | null = null) {
    if (this.showForm) {
      if (this.selectedIdForEdit == null) {
        if (this.selectedType() == "book") {

        } else if (this.selectedType() == "genre") {
          this.addGenre()
        } else if (this.selectedType() == "publisher") {
          this.addPublisher()
        }
      } else {
        if (this.selectedType() == "book") {

        } else if (this.selectedType() == "genre") {
          this.updateGenre()
        } else if (this.selectedType() == "publisher") {
          this.updatePublisher()
        }
      }
    }

    this.showForm = !this.showForm
  }

  addBook() {

  }

  addGenre() {
    console.log("addGenre")
    this.genreService.addGenre(new Genre(null, this.adminService.editorForm.controls["name"].value)).subscribe({
      next: response => {
        this.cardList.push({ id: response.id!, name: response.name })
      }
    })
  }

  addPublisher() {
    console.log("addPublisher")
    this.publisherService.addPublisher(new Publisher(
      null,
      this.adminService.editorForm.controls["name"].value,
      this.adminService.editorForm.controls["email"].value,
      this.adminService.editorForm.controls["phone"].value,
      this.adminService.editorForm.controls["isbnSign"].value
    )).subscribe({
      next: response => {
        this.cardList.push({
          id: response.id!,
          name: response.name
        })
      }
    })
  }

  //
  updateGenre() {
    console.log("updateGenre")
    this.genreService.updateGenre(new Genre(this.selectedIdForEdit, this.adminService.editorForm.controls["name"].value)).subscribe({
      next: response => {
        this.cardList[this.cardList.findIndex(c => c.id == response.id)] = { id: response.id!, name: response.name }
      }
    })
  }

  updateBook() {

  }

  updatePublisher() {
    this.publisherService.updatePublisher(new Publisher(
      this.selectedIdForEdit,
      this.adminService.editorForm.controls["name"].value,
      this.adminService.editorForm.controls["email"].value,
      this.adminService.editorForm.controls["phone"].value,
      this.adminService.editorForm.controls["isbnSign"].value
    )).subscribe({
      next: response => {
        this.cardList[this.cardList.findIndex(c => c.id == response.id)] = { id: response.id!, name: response.name }
      }
    })
  }
}
