export class BasketProduct {
    constructor(
        public id: number,
        public amount: number,
        public basketBook: Book
    ) { }
}
