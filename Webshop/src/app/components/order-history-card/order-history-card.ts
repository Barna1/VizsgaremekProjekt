import { Component, input, OnInit, output } from '@angular/core';
import { OrderHistory } from '../../models/order-history.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-order-history-card',
  imports: [CommonModule],
  templateUrl: './order-history-card.html',
  styleUrl: './order-history-card.css',
})
export class OrderHistoryCard implements OnInit{
  historyDetails = input.required<OrderHistory>()
  sumPrice: number = 0
  showDetails = output<OrderHistory>()

  ngOnInit(): void {
  const productList = this.historyDetails().orderHistoryProductList ?? [];

  for (const product of productList) {
    this.sumPrice += product.orderHistoryBook.price * product.amount;
  }
}
}