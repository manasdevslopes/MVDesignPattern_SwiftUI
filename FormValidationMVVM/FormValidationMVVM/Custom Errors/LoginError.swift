//
//  LoginError.swift
//  FormValidationMVVM
//
//  Created by MANAS VIJAYWARGIYA on 28/09/23.
//

import Foundation

enum LoginError: Error, LocalizedError {
  case emailEmpty
  case emailInvalid
  case passwordEmpty
  
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
