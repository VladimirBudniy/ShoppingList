//
//  UINavigationItem+Category.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    public func leftButtonСorrectionItems(target: AnyObject?, actionEdit: Selector, actionRemoveAll: Selector){
        let editing = UIBarButtonItem(barButtonSystemItem: .Edit, target: target, action: actionEdit)
        let removeObjects = UIBarButtonItem(barButtonSystemItem: .Trash, target: target, action: actionRemoveAll)
        
        self.leftBarButtonItems = [editing, removeObjects]
    }
}
