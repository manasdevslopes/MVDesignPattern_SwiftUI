//
//  Double.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import Foundation

extension Double {
  
  /// Converts a Double into string representation
  /// ```
  /// Convert 1.2345 to "1.23"
  /// ```
  func asNumberString() -> String {
    return String(format: "%.2f", self)
  }
  
  /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
  /// ```
  /// Convert 12 to 12.00
  /// Convert 1234 to 1.23K
  /// Convert 123456 to 123.45K
  /// Convert 12345678 to 12.34M
  /// Convert 1234567890 to 1.23Bn
  /// Convert 123456789012 to 123.45Bn
  /// Convert 12345678901234 to 12.34Tr
  /// ```
  func formattedWithAbbreviations() -> String {
    let num = abs(Double(self))
    let sign = (self < 0) ? "-" : ""
    let symbol = "\u{20B9}"
    switch num {
      case 1_000_000_000_000...:
        let formatted = num / 1_000_000_000_000
        let stringFormatted = formatted.asNumberString()
        return "\(sign)\(symbol)\(stringFormatted)Tr"
      case 1_000_000_000...:
        let formatted = num / 1_000_000_000
        let stringFormatted = formatted.asNumberString()
        return "\(sign)\(symbol)\(stringFormatted)Bn"
      case 1_000_000...:
        let formatted = num / 1_000_000
        let stringFormatted = formatted.asNumberString()
        return "\(sign)\(symbol)\(stringFormatted)M"
      case 1_000...:
        let formatted = num / 1_000
        let stringFormatted = formatted.asNumberString()
        return "\(sign)\(symbol)\(stringFormatted)K"
      case 0...:
        return "\(symbol)\(self.asNumberString())"
        
      default:
        return "\(sign)\(symbol)\(self)"
    }
  }
  
  
}
