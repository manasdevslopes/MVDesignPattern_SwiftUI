//
//  String+Extensions.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 01/10/23.
//

import Foundation

extension String {
  var isNumeric: Bool {
    Double(self) != nil
  }
  
  func isLessThan(_ number: Double) -> Bool {
    if !self.isNumeric { return false}
    
    guard let value = Double(self) else { return false }
    return value < number
  }
  
  var isNotEmpty: Bool {
    !self.isEmpty
  }
}
