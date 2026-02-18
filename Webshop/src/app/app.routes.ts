import { Routes } from '@angular/router';
import { AdminPage } from './components/admin-page/admin-page';
import { HomePage } from './components/home-page/home-page';
import { Login } from './components/login/login';
import { NotFound } from './components/not-found/not-found';
import { BillingDetailsPage } from './components/order-page/billing-details-page/billing-details-page';
import { OrderPage } from './components/order-page/order-page';
import { OrderSummaryPage } from './components/order-page/order-summary-page/order-summary-page';
import { TransportDetailsPage } from './components/order-page/transport-details-page/transport-details-page';
import { PasswordReset } from './components/password-reset/password-reset';
import { ProductDetail } from './components/product-detail/product-detail';
import { ProductList } from './components/product-list/product-list';
import { PublisherList } from './components/publisher-list/publisher-list';
import { Register } from './components/register/register';
import { Unauthorized } from './components/unauthorized/unauthorized';
import { UserPage } from './components/user-page/user-page';
import { BasketPage } from './components/order-page/basket/basket';
import { OrderHistoryPage } from './components/admin-page/order-history-page/order-history-page';
import { AdminAuthGuard } from './routeGuards/admin-auth-guard';
import { AuthenticationGuard } from './routeGuards/auth-guard';

export const routes: Routes = [
  { path: "homePage", component: HomePage, },
  { path: "", pathMatch: "full", redirectTo: "homePage" },
  { path: "productDetail/:id", component: ProductDetail },
  { path: "productList", component: ProductList },
  { path: "publisherList", component: PublisherList },
  { path: "login", component: Login },
  { path: "register", component: Register },
  { path: "passwordReset", component: PasswordReset },
  { path: "userPage", component: UserPage, canMatch: [AuthenticationGuard] },
  { path: "adminPage", component: AdminPage, canMatch: [AdminAuthGuard] },
  { path: "orderHistory", component: OrderHistoryPage, canMatch: [AdminAuthGuard] },
  {
    path: "orderPage", component: OrderPage, canMatch: [AuthenticationGuard], children: [
      { path: "basket", component: BasketPage },
      { path: "transportDetails", component: TransportDetailsPage },
      { path: "billingDetails", component: BillingDetailsPage },
      { path: "summary", component: OrderSummaryPage }
    ]
  },
  { path: "unauthorized", component: Unauthorized },
  { path: "**", component: NotFound }
];
