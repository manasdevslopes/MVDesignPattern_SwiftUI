//
//  BudgetCategory+CoreDataClass.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
  public override func awakeFromInsert() {
    self.dateCreated = Date()
  }
}
