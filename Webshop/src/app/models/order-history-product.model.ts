import { Book } from "./book.model";

export class OrderHistoryProduct {
  constructor(
    public id: number,
    public amount: number,
    public orderHistoryBook: Book
  ) { }
}
