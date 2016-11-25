//
//  UITableView+Category.swift
//  TestSwiftUI
//
//  Created by Vladimir Budniy on 11/21/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func dequeueReusableCellFromNibWithClass(cellClass: AnyClass?) -> UITableViewCell {
        let identifier = String.nameOfClass(cellClass!)
        
        var cell: UITableViewCell! = self.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            self.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            cell = self.dequeueReusableCellWithIdentifier(identifier)
        }
        
        return cell
    }
}