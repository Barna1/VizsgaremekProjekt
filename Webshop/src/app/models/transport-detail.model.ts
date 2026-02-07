import { AddressType } from "./address-type.model";

export class TransportDetail {
  constructor(
    public id: number,
    public postCode: number,
    public town: string,
    public address: string,
    public houseNumber: number,
    public other: string,
    public transportDetailAddressType: AddressType
  ) { }
}
