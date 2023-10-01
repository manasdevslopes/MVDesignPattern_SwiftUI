//
//  Product.swift
//  MVVMExample
//
//  Created by MANAS VIJAYWARGIYA on 25/09/23.
//

import Foundation

struct Product: Decodable, Identifiable {
  let id: Int
  let title: String
  let price: Double
}
