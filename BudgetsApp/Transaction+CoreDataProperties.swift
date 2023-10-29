//
//  Transaction+CoreDataProperties.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 29/10/23.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var title: String
    @NSManaged public var total: Double
    @NSManaged public var dateCreated: Date
    @NSManaged public var category: BudgetCategory?

}

extension Transaction : Identifiable {

}
