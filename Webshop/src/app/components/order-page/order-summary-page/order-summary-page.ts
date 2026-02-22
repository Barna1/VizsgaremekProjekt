import { Component, inject, OnInit } from '@angular/core';
import { OrderService } from '../../../services/order-service';
import { BasketService } from '../../../services/basket-service';
import { UserService } from '../../../services/user-service';
import { Router } from '@angular/router';
import { OrderHistory } from '../../../models/order-history.model';

@Component({
  selector: 'app-order-summary-page',
  imports: [],
  templateUrl: './order-summary-page.html',
  styleUrl: './order-summary-page.css',
})
export class OrderSummaryPage implements OnInit{
  orderService = inject(OrderService)
  basketService = inject(BasketService)
  userService = inject(UserService)
  private router = inject(Router)
  transportAddress: string = ""
  billingAddress: string = ""

  ngOnInit(): void {
    this.transportAddress = this.orderService.actualOrder.historyTransportDetail?.postCode + " " + this.orderService.actualOrder.historyTransportDetail?.town + this.orderService.actualOrder.historyTransportDetail?.address + this.orderService.actualOrder.historyTransportDetail?.houseNumber
    this.billingAddress = this.orderService.actualOrder.historyBillingDetail?.postCode + " " + this.orderService.actualOrder.historyBillingDetail?.town + this.orderService.actualOrder.historyBillingDetail?.address + this.orderService.actualOrder.historyBillingDetail?.houseNumber
  }

  sendOrder() {
    this.orderService.actualOrder.ordererUser = this.userService.loggedUser!
    this.orderService.sendOrder(this.basketService.usersBasket.id!).subscribe({
      next: response => {
        this.orderService.actualOrder = new OrderHistory()
        this.router.navigate(["/homePage"])
      }
    })
  }
}
