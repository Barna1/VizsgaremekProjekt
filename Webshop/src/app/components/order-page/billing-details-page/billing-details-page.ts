import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { OrderService } from '../../../services/order-service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { AddressType } from '../../../models/address-type.model';
import { PaymentMethod } from '../../../models/payment-method.model';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-billing-details-page',
  imports: [ReactiveFormsModule, RouterModule],
  templateUrl: './billing-details-page.html',
  styleUrl: './billing-details-page.css',
})
export class BillingDetailsPage implements OnInit{
  otherService = inject(OtherService)
  orderService = inject(OrderService)
  private router = inject(Router)
  addressTypes: AddressType[] = []
  paymentMethods: PaymentMethod[] = []
  isCompany: boolean = false
  form!: FormGroup

  ngOnInit(): void {
    this.otherService.getAllAddressType().subscribe({
      next: response => this.addressTypes = response
    })

    this.otherService.getAllPaymentMethod().subscribe({
      next: response => this.paymentMethods = response
    })

    this.form = new FormGroup({
      postCode: new FormControl("", [Validators.required]),
      town: new FormControl("", [Validators.required]),
      addressType: new FormControl("", [Validators.required]),
      address: new FormControl("", [Validators.required]),
      houseNumber: new FormControl("", [Validators.required]),
      other: new FormControl("", []),
      companyName: new FormControl("", []),
      taxNumber: new FormControl("", []),
      paymentMethod: new FormControl("", [Validators.required])
    })
  }

  continue() {

    this.router.navigate(["orderPage", "summary"])
  }
}
