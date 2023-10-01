//
//  Coffee_OrderApp.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import SwiftUI

@main
struct Coffee_OrderApp: App {
  @StateObject private var model: CoffeeModel
  
  init() {
    var config = Configuration()
    let webservice = Webservice(baseURL: config.environment.baseURL)
    _model = StateObject(wrappedValue: CoffeeModel(webservice: webservice))
  }
  
    var body: some Scene {
        WindowGroup {
          ContentView().environmentObject(model)
        }
    }
}
