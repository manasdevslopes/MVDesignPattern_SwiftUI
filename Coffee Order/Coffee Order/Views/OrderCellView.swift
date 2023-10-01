//
//  OrderCellView.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import SwiftUI

struct OrderCellView: View {
  let order: Order
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(order.name).accessibilityIdentifier("orderNameText").bold()
        Text("\(order.coffeeName) (\(order.size.rawValue))").accessibilityIdentifier("coffeeNameAndSizeText").opacity(0.5)
      }
      Spacer()
      Text(order.total as NSNumber, formatter: NumberFormatter.currency).accessibilityIdentifier("coffeePriceText")
    }
  }
}

struct OrderCellView_Previews: PreviewProvider {
    static var previews: some View {
      OrderCellView(order: Order(id: 1, name: "Manas Vijaywargiya", coffeeName: "Hot Chocolate Coffee", total: 2.0, size: .large))
    }
}
