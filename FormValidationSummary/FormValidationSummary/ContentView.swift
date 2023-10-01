//
//  ContentView.swift
//  FormValidationSummary
//
//  Created by MANAS VIJAYWARGIYA on 28/09/23.
//

import SwiftUI

enum LoginError: LocalizedError, Identifiable {
  case emailEmpty
  case emailInvalid
  case passwordEmpty
  
  var id: Int {
    hashValue
  }
  
  var errorDescription: String? {
    switch self {
      case .emailEmpty:
        return "Email is required!"
      case .emailInvalid:
        return "Email is not in correct format!"
      case .passwordEmpty:
        return "Password is required!"
    }
  }
}


struct ContentView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var errors: [LoginError] = []
  
  var isValid: Bool {
    errors.removeAll()
    if email.isEmpty {
      errors.append(.emailEmpty)
    } else if !email.isValidEmail {
      errors.append(.emailInvalid)
    }
    if password.isEmpty {
      errors.append(.passwordEmpty)
    }
    
    return errors.isEmpty
  }
  
  var body: some View {
    Form {
      TextField("Email", text: $email).textInputAutocapitalization(.never)
      
      SecureField("Password", text: $password)
      
      Button("Login") {
        if isValid {
          print("Submit the form")
        }
      }
      
      ValidationSummaryView(errors: errors)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
