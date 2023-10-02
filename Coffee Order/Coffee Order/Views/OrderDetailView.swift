//
//  OrderDetailView.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 02/10/23.
//

import SwiftUI

struct OrderDetailView: View {
  @EnvironmentObject private var model: CoffeeModel
  @State private var isPresented: Bool = false
  @Environment(\.dismiss) private var dismiss
  
  let orderId: Int
  
  var body: some View {
    VStack {
      if let order = model.orderById(orderId) {
        VStack(alignment: .leading, spacing: 10) {
          Text(order.name)
            .font(.title).frame(maxWidth: .infinity, alignment: .leading).accessibilityIdentifier("coffeeBuyerNameText")
          Text(order.coffeeName)
            .font(.title).frame(maxWidth: .infinity, alignment: .leading).accessibilityIdentifier("coffeeNameText")
          Text(order.size.rawValue).opacity(0.5)
          Text(order.total as NSNumber, formatter: NumberFormatter.currency)
          
          HStack {
            Spacer()
            Button("Delete Order", role: .destructive) {
              Task {
                await deleteOrder()
              }
            }
            Button("Edit Order") {
              isPresented.toggle()
            }.accessibilityIdentifier("editOrderButton")
            Spacer()
          }
        }.sheet(isPresented: $isPresented) {
          AddCoffeeView(order: order)
        }
      }
      Spacer()
    }
    .padding()
  }
}

struct OrderDetailView_Previews: PreviewProvider {
  static var previews: some View {
    var config = Configuration()
    OrderDetailView(orderId: 0).environmentObject(CoffeeModel(webservice: Webservice(baseURL:  config.environment.baseURL)))
  }
}

extension OrderDetailView {
  private func deleteOrder() async {
    do {
      try await model.deleteOrder(orderId)
      dismiss()
    } catch {
      print(error)
    }
  }
}
