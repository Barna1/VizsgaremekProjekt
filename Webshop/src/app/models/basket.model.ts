import { BasketProduct } from "./basket-product.model";

export class Basket {
    constructor(
        public id: number | null,
        public totalPrice: number,
        public productList?: BasketProduct[]
    ) { }
}
