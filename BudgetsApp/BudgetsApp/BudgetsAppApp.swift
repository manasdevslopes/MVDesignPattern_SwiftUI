//
//  BudgetsAppApp.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import SwiftUI

@main
struct BudgetsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
