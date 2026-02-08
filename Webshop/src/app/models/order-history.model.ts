import { BillingDetail } from "./billing-detail.model";
import { OrderHistoryProduct } from "./order-history-product.model";
import { PaymentMethod } from "./payment-method.model";
import { Status } from "./status.model";
import { TransportDetail } from "./transport-detail.model";
import { User } from "./user.model";

export class OrderHistory {
  constructor(
    public id: number,
    public firstName: string,
    public lastName: string,
    public phone: string,
    public email: string,
    public orderedAt: Date,
    public isCanceled: Boolean,
    public historyBillingDetail: BillingDetail,
    public historyTransportDetail: TransportDetail,
    public ordererUser: User | null,
    public paymentMethod: PaymentMethod,
    public status: Status,
    public cancelerUser: User | null,
    public orderHistoryProductList: OrderHistoryProduct[]
  ) { }
}
