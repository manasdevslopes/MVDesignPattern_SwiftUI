//
//  String+Extensions.swift
//  FormValidation
//
//  Created by MANAS VIJAYWARGIYA on 28/09/23.
//

import Foundation

extension String {
  var isValidEmail: Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return predicate.evaluate(with: self)
  }
}
