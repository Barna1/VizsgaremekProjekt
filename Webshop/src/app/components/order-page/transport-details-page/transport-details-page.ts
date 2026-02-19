import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { AddressType } from '../../../models/address-type.model';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { OrderService } from '../../../services/order-service';
import { TransportDetail } from '../../../models/transport-detail.model';

@Component({
  selector: 'app-transport-details-page',
  imports: [ReactiveFormsModule, RouterModule],
  templateUrl: './transport-details-page.html',
  styleUrl: './transport-details-page.css',
})
export class TransportDetailsPage implements OnInit{
  private otherService = inject(OtherService)
  private orderService = inject(OrderService)
  private router = inject(Router)
  addressTypes: AddressType[] = []
  detailsForm!: FormGroup

  ngOnInit(): void {
    this.otherService.getAllAddressType().subscribe({
      next: response => this.addressTypes = response
    })

    this.detailsForm = new FormGroup({
      firstName: new FormControl(this.orderService.actualOrder.firstName, [Validators.required]),
      lastName: new FormControl(this.orderService.actualOrder.lastName, [Validators.required]),
      email: new FormControl(this.orderService.actualOrder.email, [Validators.required, Validators.email]),
      phoneNumber: new FormControl(this.orderService.actualOrder.phone, [Validators.required]),
      postCode: new FormControl(this.orderService.actualOrder.historyTransportDetail?.postCode, [Validators.required]),
      town: new FormControl(this.orderService.actualOrder.historyTransportDetail?.town, [Validators.required]),
      addressType: new FormControl(this.orderService.actualOrder.historyTransportDetail?.transportDetailAddressType.id, [Validators.required]),
      address: new FormControl(this.orderService.actualOrder.historyTransportDetail?.address, [Validators.required]),
      houseNumber: new FormControl(this.orderService.actualOrder.historyTransportDetail?.houseNumber, [Validators.required]),
      other: new FormControl(this.orderService.actualOrder.historyTransportDetail?.other, [])
    })
  }

  continue() {
    this.orderService.actualOrder.firstName = this.detailsForm.controls["firstName"].value
    this.orderService.actualOrder.lastName = this.detailsForm.controls["lastName"].value
    this.orderService.actualOrder.phone = this.detailsForm.controls["phoneNumber"].value
    this.orderService.actualOrder.email = this.detailsForm.controls["email"].value
    this.orderService.actualOrder.historyTransportDetail = new TransportDetail(
      null,
      this.detailsForm.controls["postCode"].value,
      this.detailsForm.controls["town"].value,
      this.detailsForm.controls["address"].value,
      this.detailsForm.controls["houseNumber"].value,
      this.detailsForm.controls["other"].value,
      this.addressTypes[this.addressTypes.findIndex((at) => at.id === +this.detailsForm.controls["addressType"].value)]
    )

    this.router.navigate(["orderPage", "billingDetails"])
  }
}
