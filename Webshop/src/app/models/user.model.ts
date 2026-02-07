import { Basket } from "./basket.model";
import { Role } from "./role.model";

export class User {
  constructor(
    public id: number | null,
    public username: string,
    public email: string,
    public password: string,
    public pfpPath?: string,
    public role?: Role,
    public basket?: Basket
  ) { }
}
