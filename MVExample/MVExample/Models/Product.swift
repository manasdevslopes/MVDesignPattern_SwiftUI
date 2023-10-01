//
//  Product.swift
//  MVExample
//
//  Created by MANAS VIJAYWARGIYA on 26/09/23.
//

import Foundation

struct Product: Identifiable, Codable {
  let id: Int
  let title: String
  let price: Double
}
