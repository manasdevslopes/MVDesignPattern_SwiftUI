//
//  AddCoffeeView.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 01/10/23.
//

import SwiftUI

struct AddCoffeeView: View {
  var order: Order? = nil
  @State private var name: String = ""
  @State private var coffeeName: String = ""
  @State private var price: String = ""
  @State private var coffeeSize: CoffeeSize = .medium
  @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
  
  @EnvironmentObject private var model: CoffeeModel
  @Environment(\.dismiss) private var dismiss
  
  var isValid: Bool {
    errors = AddCoffeeErrors()
    // This is not a business Rule. Business Rule should be written on Server Side, Not client side ( UI ). This is just UI Validation
    if name.isEmpty {
      errors.name = "Name cannot be empty!"
    }
    if coffeeName.isEmpty {
      errors.coffeeName = "Coffee name cannot be empty!"
    }
    if price.isEmpty {
      errors.price = "Price cannot be empty!"
    } else if !price.isNumeric {
      errors.price = "Price needs to be a number"
    } else if price.isLessThan(1) {
      errors.price = "Price needs to be more than or equal to 1"
    }
    
    return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
  }
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name).accessibilityIdentifier("name")
        Text(errors.name).visible(errors.name.isNotEmpty).font(.caption)
        
        TextField("Coffee Name", text: $coffeeName).accessibilityIdentifier("coffeeName")
        Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty).font(.caption)
        
        TextField("Price", text: $price).accessibilityIdentifier("price")
        Text(errors.price).visible(errors.price.isNotEmpty).font(.caption)
        
        Picker("Select Size", selection: $coffeeSize) {
          ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
            Text(size.rawValue).tag(size)
          }
        }.pickerStyle(.segmented)
        Button(order != nil ? "Update Order": "Place Order") {
          if isValid {
            Task {
              await saveOrUpdate()
            }
          }
        }.centerHorizontally().accessibilityIdentifier("placeOrderButton")
      }
      .onAppear {
        populateExistingOrder()
      }
      .navigationTitle(order == nil ? "Add Order": "Update Order")
    }
  }
}

struct AddCoffeeView_Previews: PreviewProvider {
  static var previews: some View {
    var config = Configuration()
    AddCoffeeView().environmentObject(CoffeeModel(webservice: Webservice(baseURL:  config.environment.baseURL)))
  }
}

struct AddCoffeeErrors {
  var name: String = ""
  var coffeeName: String = ""
  var price: String = ""
}

extension AddCoffeeView {
  private func saveOrUpdate() async {
    if let order {
      var editOrder = order
      editOrder.name = name
      editOrder.total = Double(price) ?? 0.0
      editOrder.coffeeName = coffeeName
      editOrder.size = coffeeSize
      await updateOrder(editOrder)
    } else {
      let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0.0, size: coffeeSize)
      await placeOrder(order)
    }
    
    dismiss()
  }
  
  private func placeOrder(_ order: Order) async {
    do {
      try await model.placeOrder(order)
      dismiss()
    } catch {
      print(error)
    }
  }
  
  private func updateOrder(_ order: Order) async {
    do {
      try await model.updateOrder(order)
    } catch {
      print(error)
    }
  }
  
  private func populateExistingOrder() {
    if let order {
      name = order.name
      coffeeName = order.coffeeName
      price = String(order.total)
      coffeeSize = order.size
    }
  }
}
