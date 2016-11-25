//
//  String+Category.swift
//  TestSwiftUI
//
//  Created by Vladimir Budniy on 11/21/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation

extension String {
    public static func nameOfClass(cellClass: AnyClass) -> String {
        return NSStringFromClass(cellClass).componentsSeparatedByString(".").last!
    }
    
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
}