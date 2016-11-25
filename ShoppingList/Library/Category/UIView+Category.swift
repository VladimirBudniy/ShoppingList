//
//  UIView+Category.swift
//  TestSwiftUI
//
//  Created by Vladimir Budniy on 11/21/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func roundCorners(cornerRadius: CGFloat, borderColor: UIColor, borderWidth:CGFloat) {
        let layer = self.layer
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = borderWidth
    }
    
    public func roundCorners(cornerRadius: CGFloat) {
        let layer = self.layer
        let color = UIColor(CGColor: layer.borderColor!)
        self.roundCorners(cornerRadius, borderColor: color, borderWidth: layer.borderWidth)
    }
    
    public func adjustBorderWidth(borderWidth: CGFloat) {
        let layer = self.layer
        let color = UIColor(CGColor: layer.borderColor!)
        self.roundCorners(layer.cornerRadius, borderColor: color, borderWidth: borderWidth)
    }
    
    public func setBorderByColor(color: UIColor) {
        let layer = self.layer
        self.roundCorners(layer.cornerRadius, borderColor: color, borderWidth: layer.borderWidth)
    }
}
