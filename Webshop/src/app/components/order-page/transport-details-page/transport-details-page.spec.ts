import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TransportDetailsPage } from './transport-details-page';

describe('TransportDetailsPage', () => {
  let component: TransportDetailsPage;
  let fixture: ComponentFixture<TransportDetailsPage>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TransportDetailsPage]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TransportDetailsPage);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
