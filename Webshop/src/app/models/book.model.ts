import { Author } from "./author.model";
import { Genre } from "./genre.model";
import { Publisher } from "./publisher.model";
import { Review } from "./review.model";

export class Book {
  constructor(
    public id: number,
    public title: string,
    public description: string,
    public coverImgPath: string,
    public publishingYear: number,
    public ISBN: string,
    public price: number,
    public stockQuantity: number,
    public publisher: Publisher,
    public genreList: Genre[],
    public reviewList: Review[],
    public authors: Author[]
  ) { }
}

