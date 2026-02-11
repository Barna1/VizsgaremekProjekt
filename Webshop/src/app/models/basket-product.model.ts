import { Book } from "./book.model";

export class BasketProduct {
    constructor(
        public id: number,
        public amount: number,
        public basketBook: Book
    ) { }
}
