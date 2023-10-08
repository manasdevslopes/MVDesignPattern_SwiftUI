//
//  CoreDataManager.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import Foundation
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  private var persistenceContainer: NSPersistentContainer
  
  private init() {
    persistenceContainer = NSPersistentContainer(name: "BudgetModel")
    persistenceContainer.loadPersistentStores { description, error in
      if let error {
        fatalError("Unable to load Core Data Stack: \(error)")
      }
    }
  }
  
  var viewContext: NSManagedObjectContext {
    persistenceContainer.viewContext
  }
  
  
}
