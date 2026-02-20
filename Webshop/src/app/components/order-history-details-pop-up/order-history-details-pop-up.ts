import { Component, inject, input, OnInit, output } from '@angular/core';
import { OrderHistory } from '../../models/order-history.model';
import { OrderService } from '../../services/order-service';
import { UserService } from '../../services/user-service';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-order-history-details-pop-up',
  imports: [CommonModule, RouterModule],
  templateUrl: './order-history-details-pop-up.html',
  styleUrl: './order-history-details-pop-up.css',
})
export class OrderHistoryDetailsPopUp implements OnInit{
  orderService = inject(OrderService)
  userService = inject(UserService)
  historyDetail = input.required<OrderHistory>()
  transportAddress: string = ""
  billingAddress: string = ""
  close = output()

  ngOnInit(): void {
    this.transportAddress = this.historyDetail().historyTransportDetail?.postCode + " " + this.historyDetail().historyTransportDetail?.town + this.historyDetail().historyTransportDetail?.address + this.historyDetail().historyTransportDetail?.houseNumber
    this.billingAddress = this.historyDetail().historyBillingDetail?.postCode + " " + this.historyDetail().historyBillingDetail?.town + this.historyDetail().historyBillingDetail?.address + this.historyDetail().historyBillingDetail?.houseNumber
  }

  cancelAddress() {
    this.orderService.cancelOrder(this.historyDetail().id!, this.userService.loggedUser?.id!).subscribe({
      next: response => {

      }
    })
  }
}
