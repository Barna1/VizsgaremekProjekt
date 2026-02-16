import { Component, input } from '@angular/core';
import { OrderHistory } from '../../models/order-history.model';

@Component({
  selector: 'app-order-history-details-pop-up',
  imports: [],
  templateUrl: './order-history-details-pop-up.html',
  styleUrl: './order-history-details-pop-up.css',
})
export class OrderHistoryDetailsPopUp {
  historyDetail = input.required<OrderHistory>()
}
