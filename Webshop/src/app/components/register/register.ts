import { Component, inject, OnInit } from '@angular/core';
import { AbstractControl, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { UserService } from '../../services/user-service';
import { User } from '../../models/user.model';
import { Router, RouterModule } from '@angular/router';

function validatePassword(control: AbstractControl): { [key: string]: any } | null {
  const password: string = control.value

  const specialCharacters: string = "!@#$%^&*()-_=+[]{};:,.?/"
  const numberTexts: string = "1234567890"
  const checkerList: boolean[] = [false, false, false, false]

  for (let i: number = 0; i < password.length; i++) {
    if (specialCharacters.includes(password[i])) {
      checkerList[0] = true
    } else if (numberTexts.includes(password[i])) {
      checkerList[1] = true
    } else if (password[i] === password[i].toUpperCase()) {
      checkerList[2] = true
    } else if (password[i] === password[i].toLowerCase()) {
      checkerList[3] = true
    }
  }

  if (!checkerList.includes(false)) {
    return null
  } else {
    return { invalid: false }
  }
}

@Component({
  selector: 'app-register',
  imports: [ReactiveFormsModule, RouterModule],
  templateUrl: './register.html',
  styleUrl: './register.css',
})
export class Register implements OnInit {
  registerForm!: FormGroup;
  private userService = inject(UserService)
  private router = inject(Router)
  errorMsg: string | null = null

  samePasswordValidator = (control: AbstractControl): { [key: string]: any } | null => {
    let originalPassword = this.registerForm.controls["password"].value
    if (control.value === originalPassword) {
      return null
    } else {
      return { invalid: false }
    }
  }

  ngOnInit(): void {
    this.registerForm = new FormGroup({
      username: new FormControl("", [Validators.required]),
      email: new FormControl("", [Validators.required]),
      password: new FormControl("", [Validators.required, validatePassword]),
      passwordAgain: new FormControl("", [Validators.required, validatePassword])
    })

    this.registerForm.controls["passwordAgain"].addValidators(this.samePasswordValidator)
  }

  sendRegister() {
    const newUser: User = new User(null, this.registerForm.controls["username"].value, this.registerForm.controls["email"].value, this.registerForm.controls["password"].value)
    this.userService.register(newUser).subscribe({
      next: response => {
        console.log(response)
      },
      error: error => console.log(error),
      complete: () => {
        this.router.navigate(["/login"])
      }
    })
  }
}
