//
//  PurchaseView.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit
import MagicalRecord

class PurchaseView: UIView {

    @IBOutlet weak var goodsNameText: UITextField!
    @IBOutlet weak var goodsQuantityText: UITextField!
    @IBOutlet weak var goodsPriceText: UITextField!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    func customButtonView() {
        self.buttonView.roundCorners(5, borderColor: UIColor.blackColor(), borderWidth: 1)
    }
    
}
