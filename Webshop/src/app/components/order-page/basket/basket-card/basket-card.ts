import { Component, inject, input, output } from '@angular/core';
import { RouterModule } from '@angular/router';
import { BasketService } from '../../../../services/basket-service';
import { BasketProduct } from '../../../../models/basket-product.model';
import { UserService } from '../../../../services/user-service';

@Component({
  selector: 'app-basket-card',
  imports: [RouterModule],
  templateUrl: './basket-card.html',
  styleUrl: './basket-card.css',
})
export class BasketCard {
  book = input.required<BasketProduct>()
  basketService = inject(BasketService)
  userService = inject(UserService)
  changeAmount = output<number>()

  changeAmountOfProduct(plusValue: 1 | -1) {
    this.basketService.changeAmountOfProduct(this.userService.loggedUser?.id!, {productId: this.book().id, amount: this.book().amount + plusValue}).subscribe({
      next: response => {
        if (this.book().amount + plusValue === 0) {
          this.basketService.usersBasket.productList = this.basketService.usersBasket.productList?.filter((bp) => bp.id != this.book().id)
        } else {
          this.changeAmount.emit(this.book().amount + plusValue)
        }
      }
    })
  }

  deleteProductFromBasket() {
    this.basketService.deleteProduct(this.book().id, this.userService.loggedUser?.id!).subscribe({
      next: response => {
        this.basketService.usersBasket.productList = this.basketService.usersBasket.productList?.filter((bp) => bp.id != this.book().id)
      }
    })
  }
}
