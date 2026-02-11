import { HttpClient } from "@angular/common/http";
import { inject, Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { PaymentMethod } from "../models/payment-method.model";
import { AddressType } from "../models/address-type.model";

@Injectable({
    providedIn: 'root'
})

export class OtherService {
    private baseUrl:string = "http://localhost:8080"
    private http = inject(HttpClient)

    getAllPaymentMethod(): Observable<PaymentMethod[]> {
        return this.http.get<PaymentMethod[]>(`${this.baseUrl}/paymentMethods`)
    }

    getAllAddressType(): Observable<AddressType[]> {
        return this.http.get<AddressType[]>(`${this.baseUrl}/addressType`)
    }
}
