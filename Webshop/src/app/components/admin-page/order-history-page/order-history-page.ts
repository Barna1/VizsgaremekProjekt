import { Component, inject, OnInit } from '@angular/core';
import { OrderService } from '../../../services/order-service';
import { OrderHistoryDetailsPopUp } from '../../order-history-details-pop-up/order-history-details-pop-up';
import { OrderHistory } from '../../../models/order-history.model';
import { OrderHistoryCard } from '../../order-history-card/order-history-card';

@Component({
  selector: 'app-order-history-page',
  imports: [OrderHistoryDetailsPopUp, OrderHistoryCard],
  templateUrl: './order-history-page.html',
  styleUrl: './order-history-page.css',
})
export class OrderHistoryPage implements OnInit {
  orderService = inject(OrderService)
  selectedOrderHistory: OrderHistory | null = null;
  orderHistories: OrderHistory[] = []

  ngOnInit(): void {
    this.orderService.getAllOrder().subscribe({
      next: response => this.orderHistories = response
    })
  }
}
