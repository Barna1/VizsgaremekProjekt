import { Component, inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { UserService } from '../../services/user-service';
import { BasketService } from '../../services/basket-service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule, RouterModule, CommonModule],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login implements OnInit {
  router = inject(Router)
  userService = inject(UserService)
  basketService = inject(BasketService)
  showError: boolean = false
  loginForm!: FormGroup;

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      username: new FormControl("", [Validators.required]),
      password: new FormControl("", [Validators.required])
    })
  }

  sendLoging() {
    this.userService.login(this.loginForm.controls["username"].value, this.loginForm.controls["password"].value).subscribe({
      next: response => this.userService.loggedUser = response,
      error: error => console.log(error),
      complete: () => {
        this.router.navigate(["/homePage"])
      }
    })
  }
}
