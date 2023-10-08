//
//  BudgetCategory+CoreDataProperties.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//
//

import Foundation
import CoreData


extension BudgetCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetCategory> {
        return NSFetchRequest<BudgetCategory>(entityName: "BudgetCategory")
    }

    @NSManaged public var title: String
    @NSManaged public var total: Double
    @NSManaged public var dateCreated: Date

}

extension BudgetCategory : Identifiable {

}
