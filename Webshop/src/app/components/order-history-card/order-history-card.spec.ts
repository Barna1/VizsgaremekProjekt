import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrderHistoryCard } from './order-history-card';

describe('OrderHistoryCard', () => {
  let component: OrderHistoryCard;
  let fixture: ComponentFixture<OrderHistoryCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrderHistoryCard]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OrderHistoryCard);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
