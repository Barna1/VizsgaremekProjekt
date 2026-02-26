import { UserService } from './../../services/user-service';
import { Component, inject } from '@angular/core';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-navbar',
  imports: [RouterModule],
  templateUrl: './navbar.html',
  styleUrl: './navbar.css',
})
export class Navbar {
  router = inject(Router)
  userService = inject(UserService)

  navigateUserButton() {
    if (this.userService.loggedUser == null) {
      this.router.navigate(["/login"])
    } else {
      this.router.navigate(["/userPage"])
    }
  }
}
