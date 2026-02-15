import { Component, inject, OnInit } from '@angular/core';
import { OtherService } from '../../../services/other-service';
import { AddressType } from '../../../models/address-type.model';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { OrderService } from '../../../services/order-service';

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
      firstName: new FormControl("", [Validators.required]),
      lastName: new FormControl("", [Validators.required]),
      email: new FormControl("", [Validators.required, Validators.email]),
      phoneNumber: new FormControl("", [Validators.required]),
      postCode: new FormControl("", [Validators.required]),
      town: new FormControl("", [Validators.required]),
      addressType: new FormControl("", [Validators.required]),
      address: new FormControl("", [Validators.required]),
      houseNumber: new FormControl("", [Validators.required]),
      other: new FormControl("", [])
    })
  }

  continue() {

    this.router.navigate(["orderPage", "billingDetails"])
  }
}
