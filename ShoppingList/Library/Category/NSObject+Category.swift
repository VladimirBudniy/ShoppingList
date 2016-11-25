//
//  NSObject+Category.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/25/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation

extension NSObject {
    public static func className() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}
