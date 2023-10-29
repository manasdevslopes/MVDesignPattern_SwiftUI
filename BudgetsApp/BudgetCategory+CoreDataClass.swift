//
//  BudgetCategory+CoreDataClass.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 29/10/23.
//
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
  override public func awakeFromInsert() {
    self.dateCreated = Date()
  }
  
  private var transactionsArray: [Transaction] {
    guard let transactions = transactions else { return [] }
    let allTransactions = (transactions.allObjects as? [Transaction]) ?? []
    return allTransactions.sorted(by: { $0.dateCreated > $1.dateCreated })
  }
  
  var transactionsTotal: Double {
    transactionsArray.reduce(0, { $0 + $1.total })
  }
  
  var remainingBudgetTotal: Double {
    self.total - transactionsTotal
  }
  
  var overSpent: Bool {
    remainingBudgetTotal < 0
  }
  
  static var all: NSFetchRequest<BudgetCategory> {
    let request = BudgetCategory.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
    return request
  }
  
  static func byId(_ id: NSManagedObjectID) -> BudgetCategory {
    let vc = CoreDataManager.shared.viewContext
    guard let budgetCategory = vc.object(with: id) as? BudgetCategory else { fatalError("Id not found") }
    return budgetCategory
  }
  
  static func transactionsByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
    let request = Transaction.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
    request.predicate = NSPredicate(format: "category = %@", budgetCategory)
    return request
  }
}
