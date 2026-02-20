import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { OrderService } from '../../../services/order-service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { AddressType } from '../../../models/address-type.model';
import { PaymentMethod } from '../../../models/payment-method.model';
import { Router, RouterModule } from '@angular/router';
import { BillingDetail } from '../../../models/billing-detail.model';

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
      postCode: new FormControl(this.orderService.actualOrder.historyBillingDetail?.postCode, [Validators.required]),
      town: new FormControl(this.orderService.actualOrder.historyBillingDetail?.town, [Validators.required]),
      addressType: new FormControl(this.orderService.actualOrder.historyBillingDetail?.billingDetailsAddressType.id, [Validators.required]),
      address: new FormControl(this.orderService.actualOrder.historyBillingDetail?.address, [Validators.required]),
      houseNumber: new FormControl(this.orderService.actualOrder.historyBillingDetail?.houseNumber, [Validators.required]),
      other: new FormControl(this.orderService.actualOrder.historyBillingDetail?.other, []),
      // companyName: new FormControl(this.orderService.actualOrder.historyBillingDetail?.companyName, []),
      // taxNumber: new FormControl(this.orderService.actualOrder.historyBillingDetail?.companyTaxNumber, []),
      paymentMethod: new FormControl(this.orderService.actualOrder.paymentMethod?.id, [Validators.required])
    })
  }

  continue() {
    const billingDetail: BillingDetail = new BillingDetail(
      null,
      this.form.controls["postCode"].value,
      this.form.controls["town"].value,
      this.form.controls["address"].value,
      this.form.controls["houseNumber"].value,
      this.isCompany ? this.form.controls["companyName"].value : null,
      this.isCompany ? this.form.controls["taxNumber"].value : null,
      this.form.controls["other"].value,
      this.addressTypes[this.addressTypes.findIndex(at => at.id === this.form.controls["addressType"].value)],
    )

    this.orderService.actualOrder.historyBillingDetail = billingDetail
    this.orderService.actualOrder.paymentMethod = this.paymentMethods[this.paymentMethods.findIndex(pm => pm.id === this.form.controls["paymentMethod"].value)]
    this.router.navigate(["orderPage", "summary"])
  }

  setPaymentMethod(selectedId: number) {
    this.form.controls["paymentMethod"].setValue(selectedId)
  }

  handleCompany() {
    if (this.isCompany) {
      this.form.removeControl("companyName")
      this.form.removeControl("taxNumber")
    } else {
      this.form.addControl("companyName", new FormControl(this.orderService.actualOrder.historyBillingDetail?.companyName, [Validators.required]))
      this.form.addControl("taxNumber", new FormControl(this.orderService.actualOrder.historyBillingDetail?.companyTaxNumber, [Validators.required]))
    }

    this.isCompany = !this.isCompany
  }
}
