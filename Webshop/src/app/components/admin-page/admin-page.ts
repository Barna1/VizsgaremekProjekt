import { Component, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Popup } from './popup/popup';

@Component({
  selector: 'app-admin-page',
  imports: [RouterModule, Popup],
  templateUrl: './admin-page.html',
  styleUrl: './admin-page.css',
})
export class AdminPage implements OnInit {
  isShowPopUp: boolean = false
  selectedType!: "genre" | "book" | "publisher"

  ngOnInit(): void {

  }

  showPopup(selectedType: "genre" | "book" | "publisher") {
    this.selectedType = selectedType
    this.isShowPopUp = true
  }
}