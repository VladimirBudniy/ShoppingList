//
//  Purchase+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/25/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Purchase {

    @NSManaged var date: NSDate?
    @NSManaged var name: String?
    @NSManaged var price: NSNumber?
    @NSManaged var quantity: NSNumber?

}
