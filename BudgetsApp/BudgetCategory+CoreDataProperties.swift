//
//  BudgetCategory+CoreDataProperties.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 29/10/23.
//
//

import Foundation
import CoreData


extension BudgetCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetCategory> {
        return NSFetchRequest<BudgetCategory>(entityName: "BudgetCategory")
    }

    @NSManaged public var dateCreated: Date
    @NSManaged public var title: String
    @NSManaged public var total: Double
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension BudgetCategory {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension BudgetCategory : Identifiable {

}
