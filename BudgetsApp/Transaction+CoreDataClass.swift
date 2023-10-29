//
//  Transaction+CoreDataClass.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 29/10/23.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
  override public func awakeFromInsert() {
    self.dateCreated = Date()
  }
}
