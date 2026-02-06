import { Book } from "./book.model";

export class Publisher {
  constructor(
    public id:number,
    public name:string,
    public email:string,
    public phone:string,
    public isbnSign:string,
    public bookList:Book[]
  ) { }
}
