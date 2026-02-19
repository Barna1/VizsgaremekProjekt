import { Component, input, output } from '@angular/core';

@Component({
  selector: 'app-list-card',
  imports: [],
  templateUrl: './list-card.html',
  styleUrl: './list-card.css',
})
export class ListCard {
  card = input.required<{id: number, name: string}>()
  edit = output()
  delete = output()
}
