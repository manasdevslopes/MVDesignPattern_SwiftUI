//
//  ContentView.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var model: CoffeeModel
  
  @State private var isPresented: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        if model.orders.isEmpty {
          Text("No Orders Available!").accessibilityIdentifier("noOrdersText")
        } else {
          List {
            ForEach(model.orders) { order in
              NavigationLink(value: order.id) {
                OrderCellView(order: order)
              }
            }.onDelete(perform: deleteOrder)
          }.accessibilityIdentifier("orderList")
        }
      }
      .navigationDestination(for: Int.self, destination: { orderId in
        OrderDetailView(orderId: orderId)
      })
      .task {
        await populateOrders()
      }
      .sheet(isPresented: $isPresented) {
        AddCoffeeView()
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Add New Order") {
            isPresented.toggle()
          }.accessibilityIdentifier("addNewOrderButton")
        }
      }
    }
  }
}

extension ContentView {
  private func populateOrders() async {
    do {
      try await model.populateOrders()
    } catch {
      print(error)
    }
  }
  
  private func deleteOrder(_ indexSet: IndexSet) {
    indexSet.forEach { index in
      print("INDEX__------->", index)
      let order = model.orders[index]
      print("ORDER------->", order)
      guard let orderId = order.id else { return }
      print("orderId------->", orderId)
      Task {
        do {
          try await model.deleteOrder(orderId)
        } catch {
          print(error)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    var config = Configuration()
    ContentView().environmentObject(CoffeeModel(webservice: Webservice(baseURL:  config.environment.baseURL)))
  }
}
