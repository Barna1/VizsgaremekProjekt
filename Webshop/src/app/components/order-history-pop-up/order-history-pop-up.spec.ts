import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrderHistoryPopUp } from './order-history-pop-up';

describe('OrderHistoryPopUp', () => {
  let component: OrderHistoryPopUp;
  let fixture: ComponentFixture<OrderHistoryPopUp>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrderHistoryPopUp]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OrderHistoryPopUp);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
