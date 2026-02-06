import { AddressType } from "./address-type.model";

export class BillingDetail {
  constructor(
    public id: number,
    public postCode: number,
    public town: string,
    public address: string,
    public houseNumber: number,
    public companyName: string | null = null,
    public companyTaxNumber: string | null = null,
    public other: string,
    public billingDetailsAddressType: AddressType,
  ) {}
}
