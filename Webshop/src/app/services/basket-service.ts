import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Basket } from '../models/basket.model';
import { BasketProduct } from '../models/basket-product.model';

@Injectable({
  providedIn: 'root',
})
export class BasketService {
  private baseUrl = "http://localhost:8080/basket"
  private http = inject(HttpClient)
  usersBasket!: Basket

  getBasketByUserId(userId: number): Observable<Basket> {
  const token = localStorage.getItem('token');

  return this.http.get<Basket>(`${this.baseUrl}/user/${userId}`, {
    headers: {
      Authorization: `Bearer ${token}`
    }
  });
}

  deleteProduct(basketProductId: number, basketId:number){
    return this.http.delete(`${this.baseUrl}/book?basketProductId=${basketProductId}&basketId=${basketId}`)
  }

  changeAmountOfProduct(basketId:number, body: {productId:number, newAmount:number}): Observable<BasketProduct> {
    return this.http.patch<BasketProduct>(`${this.baseUrl}/${basketId}`, body)
  }

  addProductToBasket(basketId:number, body: {productId: number, amount: number}) {
    return this.http.post(`${this.baseUrl}/${basketId}`, body)
  }

  clearBasket(basketId: number) {
    return this.http.delete(`${this.baseUrl}/${basketId}/clear`)
  }
}
