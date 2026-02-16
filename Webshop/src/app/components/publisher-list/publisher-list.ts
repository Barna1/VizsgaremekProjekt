import { Component, inject, OnInit } from '@angular/core';
import { PublisherService } from '../../services/publisher-service';
import { Publisher } from '../../models/publisher.model';

@Component({
  selector: 'app-publisher-list',
  imports: [],
  templateUrl: './publisher-list.html',
  styleUrl: './publisher-list.css',
})
export class PublisherList implements OnInit{
  publisherService = inject(PublisherService)
  publishers: Publisher[] = []

  ngOnInit(): void {
    this.publisherService.getAllPublisher().subscribe({
      next: response => this.publishers = response
    })
  }

}
