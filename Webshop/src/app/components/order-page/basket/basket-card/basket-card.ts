import { Component, inject, input, output } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Book } from '../../../../models/book.model';
import { BasketService } from '../../../../services/basket-service';
import { BasketProduct } from '../../../../models/basket-product.model';

@Component({
  selector: 'app-basket-card',
  imports: [RouterModule],
  templateUrl: './basket-card.html',
  styleUrl: './basket-card.css',
})
export class BasketCard {
  book = input.required<BasketProduct>()
  basketId = input.required<number>()
  basketService = inject(BasketService)
  delete = output<number>()
  changeAmount = output<number>()

  changeAmountOfProduct(plusValue: 1 | -1) {
    this.basketService.changeAmountOfProduct(this.basketId(), {productId: this.book().id, amount: this.book().amount + plusValue}).subscribe({
      next: response => {
        this.changeAmount.emit(this.book().amount + plusValue)
      }
    })
  }

  deleteProductFromBasket(id: number) {
    this.basketService.deleteProduct(id, this.basketId()).subscribe({
      next: response => {
        this.delete.emit(id)
      }
    })
  }
}
