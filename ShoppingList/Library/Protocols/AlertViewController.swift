//
//  AlertViewController.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/25/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

protocol AlertViewController {
    var alertViewController: UIAlertController { get }
}

extension AlertViewController {
    
    var alertViewController: UIAlertController {
        let alertView = self.alertViewControllerWith(nil,
            message: "Are you sure that want to save a purchase?",
            preferredStyle: UIAlertControllerStyle.Alert,
            actionTitle: "Yes",
            style: UIAlertActionStyle.Default,
            handler: nil)
        
        return alertView
    }
    
    func alertViewControllerWith(title: String?, message: String, preferredStyle: UIAlertControllerStyle, actionTitle: String, style: UIAlertActionStyle, handler:((UIAlertAction) -> Void)?) -> UIAlertController
    {
        let alertView = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle)
        
        let alertAction = UIAlertAction(
            title: actionTitle,
            style: style,
            handler: handler)
        
        alertView.addAction(alertAction)
        
        return alertView
    }
}