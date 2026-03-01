import { OrderHistory } from './../models/order-history.model';
import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class OrderService {
  http = inject(HttpClient)
  baseUrl = "http://localhost:8080/order"
  actualOrder: OrderHistory = new OrderHistory()

  getOrderHistoryByUserId(userId: number): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(`${this.baseUrl}/user/${userId}`)
  }

  cancelOrder(orderId: number, userId: number | null): Observable<OrderHistory> {
    return this.http.delete<OrderHistory>(`${this.baseUrl}/cancel?orderId=${orderId}&userId=${userId}`)
  }

  getAllOrder(): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(`${this.baseUrl}`)
  }

  sendOrder(basketId: number) {
    return this.http.post(`${this.baseUrl}/${basketId}`, this.actualOrder)
  }
}
