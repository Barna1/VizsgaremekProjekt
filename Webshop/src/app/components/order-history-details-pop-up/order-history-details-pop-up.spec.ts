import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrderHistoryDetailsPopUp } from './order-history-details-pop-up';

describe('OrderHistoryDetailsPopUp', () => {
  let component: OrderHistoryDetailsPopUp;
  let fixture: ComponentFixture<OrderHistoryDetailsPopUp>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrderHistoryDetailsPopUp]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OrderHistoryDetailsPopUp);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
