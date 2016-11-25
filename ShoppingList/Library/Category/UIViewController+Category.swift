//
//  UIViewController+Category.swift
//  TestSwiftUI
//
//  Created by Vladimir Budniy on 11/21/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public class func controllerFromNibWithName(name: String) -> AnyObject {
        return self.init(nibName: name, bundle: nil)
    }
    
    public class func controllerFromNib() -> AnyObject {
        return self.controllerFromNibWithName(String.nameOfClass(self))
    }
}
