import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BasketCard } from './basket-card';

describe('BasketCard', () => {
  let component: BasketCard;
  let fixture: ComponentFixture<BasketCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BasketCard]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BasketCard);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
