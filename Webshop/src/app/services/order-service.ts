import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { OrderHistory } from '../models/order-history.model';

@Injectable({
  providedIn: 'root',
})
export class OrderService {
  private baseUrl = 'http://localhost:8080/order';
  private http = inject(HttpClient);

  getOrderHistoryById(userId: number): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(`${this.baseUrl}/user/${userId}`);
  }

  cancelOrder(orderId: number, userId: number | null) {
    return this.http.delete('');
  }

  getOrderHistoryByVCode(email: string, vCode: string): Observable<OrderHistory> {
    return this.http.get<OrderHistory>('');
  }

  getAllOrder(): Observable<OrderHistory[]> {
    return this.http.get<OrderHistory[]>(`${this.baseUrl}`);
  }

  sendOrder(newOrder: OrderHistory, basketId: number) {
    return this.http.post('', newOrder);
  }
}
