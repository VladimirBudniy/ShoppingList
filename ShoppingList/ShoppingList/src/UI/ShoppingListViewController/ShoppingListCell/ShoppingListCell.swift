//
//  ShoppingListCell.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit

class ShoppingListCell: UITableViewCell {
    
    @IBOutlet weak var goodsLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Initialisation
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public
    
    internal func fillWithObject(object: Purchase) {
        goodsLabel.text = object.name
        quantityLabel.text = object.quantity?.stringValue
        priceLabel.text = object.price?.stringValue
    }
}
