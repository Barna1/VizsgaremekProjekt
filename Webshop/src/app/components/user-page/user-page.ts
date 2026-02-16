import { Component, inject, OnInit } from '@angular/core';
import { OrderHistoryCard } from '../order-history-card/order-history-card';
import { OrderHistoryDetailsPopUp } from '../order-history-details-pop-up/order-history-details-pop-up';
import { OrderService } from '../../services/order-service';
import { UserService } from '../../services/user-service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { OrderHistory } from '../../models/order-history.model';
import { Router } from '@angular/router';

@Component({
  selector: 'app-user-page',
  imports: [OrderHistoryCard, OrderHistoryDetailsPopUp, ReactiveFormsModule],
  templateUrl: './user-page.html',
  styleUrl: './user-page.css',
})
export class UserPage implements OnInit{
  orderService = inject(OrderService)
  userService = inject(UserService)
  router = inject(Router)
  updateForm!: FormGroup
  orderHistoryList: OrderHistory[] = []
  selectedOrderHistory: OrderHistory | null = null
  showDelete: boolean = false
  showInputs: boolean = false

  ngOnInit(): void {
    this.orderService.getOrderHistoryById(this.userService.loggedUser?.id!).subscribe({
      next: response => this.orderHistoryList = response,
    })

    this.updateForm = new FormGroup({
      username: new FormControl(this.userService.loggedUser?.username, [Validators.required]),
      email: new FormControl(this.userService.loggedUser?.email, [Validators.required, Validators.email])
    })
  }

  updateProfile() {
    this.showInputs = !this.showInputs
    if (!this.showInputs) {
      this.userService.update(this.userService.loggedUser?.id!, {username: this.updateForm.controls["username"].value, email: this.updateForm.controls["email"].value}).subscribe({
        next: response => this.userService.loggedUser = response
      })
    }
  }

  updatePfp() {

  }

  deleteProfile() {
    this.userService.deleteUser(this.userService.loggedUser?.id!).subscribe({
      next: response => console.log(response),
      complete: () => this.router.navigate([""])
    })
  }
}
