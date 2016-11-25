//
//  UIWindow+Category.swift
//  TestSwiftUI
//
//  Created by Vladimir Budniy on 11/21/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    public class func window() -> UIWindow {
        return UIWindow(frame: UIScreen.mainScreen().bounds)
    }
}