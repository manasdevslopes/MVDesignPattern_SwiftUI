//
//  Order.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import Foundation

enum CoffeeOrderError: Error {
  case inValidOrderId
}
enum CoffeeSize: String, CaseIterable, Codable {
  case small = "Small"
  case medium = "Medium"
  case large = "Large"
}

struct Order: Codable, Identifiable, Hashable {
  var id: Int?
  var name: String
  var coffeeName: String
  var total: Double
  var size: CoffeeSize
}
