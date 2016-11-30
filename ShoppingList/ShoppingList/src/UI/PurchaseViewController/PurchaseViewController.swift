//
//  PurchaseViewController.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit
import MagicalRecord

class PurchaseViewController: UIViewController, AlertViewController, ViewControllerRootView, UITextFieldDelegate {
    
    // MARK: - Accessors
    var purchase: Purchase?
    
    typealias RootViewType = PurchaseView
   
    // MARK: - Initialization

    init(purchase: Purchase?) {
        self.purchase = purchase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.addTextFieldDelegate()
        self.rootView.customButtonView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.purchase != nil {
            self.rootView.fillFields(self.purchase)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action
    
    @IBAction func addObject(sender: AnyObject) {
        self.saveObject()
    }
    
    // MARK: - Private
    
    private func saveObject() {
        let currentView = self.rootView
        
        MagicalRecord.saveWithBlock({ [weak self] context in
            let date = self!.purchase?.date
            if date == nil {
                let purchase = Purchase.MR_createEntityInContext(context)!
                purchase.name = currentView.goodsNameText.text
                purchase.quantity = ((currentView.goodsQuantityText.text!) as NSString).floatValue
                purchase.price = ((currentView.goodsPriceText.text!) as NSString).floatValue
                purchase.date = NSDate()
            } else {
                let localPurchase = Purchase.MR_findFirstByAttribute("date", withValue: date!, inContext: context)
                if localPurchase != nil {
                    localPurchase!.name = currentView.goodsNameText.text
                    localPurchase!.quantity = ((currentView.goodsQuantityText.text!) as NSString).floatValue
                    localPurchase!.price = ((currentView.goodsPriceText.text!) as NSString).floatValue
                }
            }
            }, completion: {(success, error) in
                if success {
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
                if (error != nil) {
                    self.presentViewController(self.alertViewController, animated: true, completion: nil)
                }
        })
    }
    
    private func addTextFieldDelegate() {
        let view = self.rootView
        view.goodsNameText.delegate = self;
        view.goodsQuantityText.delegate = self;
        view.goodsPriceText.delegate = self;
    }
    
    private func checkCharacterValues(textField: UITextField) -> Bool {
        let numbersOnly = NSCharacterSet(charactersInString:".0123456789")
        let characterSetFromTextField = NSCharacterSet(charactersInString:textField.text!)
        let bool = numbersOnly.isSupersetOfSet(characterSetFromTextField)
        
        if bool == false {
            let alertController = alertViewControllerWith(nil,
                message: "Please specify only (.) and numerical values!",
                preferredStyle: UIAlertControllerStyle.Alert,
                actionTitle: "Ok",
                style: UIAlertActionStyle.Default,
                handler: nil)
            self.presentViewController(alertController, animated: true, completion: nil)
            textField.text = ""
        }
        
        return true
    }
    
    // MARK: - UITextFieldDelegate Protocol Reference
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case let textField where textField == self.rootView.goodsNameText:
            self.rootView.goodsQuantityText.becomeFirstResponder()
            return true
            
        case let textField where textField == self.rootView.goodsQuantityText:
            checkCharacterValues(textField)
            self.rootView.goodsPriceText.becomeFirstResponder()
            
            return true
            
        case let textField where textField == self.rootView.goodsPriceText:
            checkCharacterValues(textField)
            return self.rootView.goodsPriceText.endEditing(true)
            
        default:
            return true
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case let textField where textField == self.rootView.goodsNameText:
            return true
            
        case let textField where textField == self.rootView.goodsQuantityText:
            return self.checkCharacterValues(textField)

        case let textField where textField == self.rootView.goodsPriceText:
            return self.checkCharacterValues(textField)
            
        default:
            return true
        }
    }
    
}

