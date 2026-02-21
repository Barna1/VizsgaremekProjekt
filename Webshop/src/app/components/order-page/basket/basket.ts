import { Component, inject, OnInit } from '@angular/core';
import { BasketCard } from './basket-card/basket-card';
import { BasketService } from '../../../services/basket-service';
import { UserService } from '../../../services/user-service';
import { Basket } from '../../../models/basket.model';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-basket',
  imports: [BasketCard, RouterModule],
  templateUrl: './basket.html',
  styleUrl: './basket.css',
})
export class BasketPage implements OnInit {
  basketService = inject(BasketService)
  userService = inject(UserService)

  ngOnInit(): void {
    this.basketService.getBasketByUserId(11).subscribe({
      next: response => {
        this.basketService.usersBasket = response
      },
    })
  }

  changeAmount(newAmount: number, index: number) {
    const searchedProduct = this.basketService.usersBasket.productList![index]
    searchedProduct.amount = newAmount
    this.basketService.usersBasket.productList![index] = searchedProduct
  }

  clearBasket() {

  }
}
