//
//  ContentView.swift
//  FormValidation
//
//  Created by MANAS VIJAYWARGIYA on 28/09/23.
//

import SwiftUI

struct ContentView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var loginFormError = LoginFormError()
  
  private func clearForm() {
    loginFormError = LoginFormError()
  }
  
  var body: some View {
    Form {
      TextField("Email", text: $email).textInputAutocapitalization(.never)
      if !loginFormError.email.isEmpty {
        Text(loginFormError.email).font(.caption)
      }
      SecureField("Password", text: $password)
      if !loginFormError.password.isEmpty {
        Text(loginFormError.password).font(.caption)
      }
      Button("Login") {
        if isFormValid {
          // Submit the form
        }
      }
//      .disabled(!isFormValid)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


extension ContentView {
  var isFormValid: Bool {
    //    return !email.isEmpty && !password.isEmpty && email.isValidEmail
    
    clearForm()
    if email.isEmpty {
      loginFormError.email = "Email is required!"
    } else if !email.isValidEmail {
      loginFormError.email = "Email is not in correct format!"
    }
    if password.isEmpty {
      loginFormError.password = "Password is required!"
    }
    return loginFormError.email.isEmpty && loginFormError.password.isEmpty
  }
  
}
