import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrderSummaryPage } from './order-summary-page';

describe('OrderSummaryPage', () => {
  let component: OrderSummaryPage;
  let fixture: ComponentFixture<OrderSummaryPage>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrderSummaryPage]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OrderSummaryPage);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
