//
//  MVExampleApp.swift
//  MVExample
//
//  Created by MANAS VIJAYWARGIYA on 26/09/23.
//

import SwiftUI

@main
struct MVExampleApp: App {
  @StateObject private var storeModel = StoreModel(webservice: Webservice())
  
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(storeModel)
    }
  }
}
