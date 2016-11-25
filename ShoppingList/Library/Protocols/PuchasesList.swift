//
//  PuchasesList.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/24/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import MagicalRecord

protocol PuchasesList {
    var puchasesList: NSArray {get}
}

extension PuchasesList {
    var puchasesList: NSArray {
        get {
            return Purchase.MR_findAllSortedBy("date", ascending: false)!
        }
    }
    
    func removeAllObjectsFromDatabase() {
        Purchase.MR_truncateAll()
    }
    
    internal func removeObjectFromDatabaseAtIndex(index: Int) {
        let object = puchasesList.objectAtIndex(index) as! Purchase
        object.MR_deleteEntity()
    }
}