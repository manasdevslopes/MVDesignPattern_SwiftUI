//
//  ContentView.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var model: CoffeeModel
  
  var body: some View {
    VStack {
      if model.orders.isEmpty {
        Text("No Orders Available!").accessibilityIdentifier("noOrdersText")
      }
      List(model.orders) { order in
        OrderCellView(order: order)
      }
    }
    .task {
      await populateOrders()
    }
  }
}

extension ContentView {
  func populateOrders() async {
    do {
      try await model.populateOrders()
    } catch {
      print(error)
    }
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    var config = Configuration()
    ContentView().environmentObject(CoffeeModel(webservice: Webservice(baseURL:  config.environment.baseURL)))
  }
}
