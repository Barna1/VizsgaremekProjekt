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
    for (let i: number = 0; i <this.historyDetails().orderHistoryProductList!.length; i++) {
      this.sumPrice += (this.historyDetails().orderHistoryProductList![i].orderHistoryBook.price * this.historyDetails().orderHistoryProductList![i].amount)
    }
  }
}
