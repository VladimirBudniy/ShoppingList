//
//  PurchaseViewController.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit
import MagicalRecord

class PurchaseViewController: UIViewController, ViewControllerRootView, AlertViewController, UITextFieldDelegate {
    
    // MARK: - Accessors
    
    typealias RootViewType = PurchaseView
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextFieldDelegate(self)
        rootView.customButtonView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action
    
    @IBAction func addObject(sender: AnyObject) {
        saveObject()
//        presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    func saveObject() {
        let purchase = Purchase.MR_createEntity()
        MagicalRecord.saveWithBlock( {_ in self.fillWithPurchase(purchase!)} ) // !!!!!!!!!!!!!!!!!!!!!!!!!!
        navigationController?.popViewControllerAnimated(true)
    }
    
    func fillWithPurchase(purchase: Purchase) {
        purchase.name = rootView.goodsNameText.text
        purchase.quantity = ((rootView.goodsQuantityText.text!) as NSString).floatValue
        purchase.price = ((rootView.goodsPriceText.text!) as NSString).floatValue
        purchase.date = NSDate.init()
    }
    
    func addTextFieldDelegate<T: UITextFieldDelegate>(delegate: T) {
        rootView.goodsNameText.delegate = delegate;
        rootView.goodsQuantityText.delegate = delegate;
        rootView.goodsPriceText.delegate = delegate;
    }
    
    func checkCharacterValues(textField: UITextField) -> Bool {
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
            presentViewController(alertController, animated: true, completion: nil)
            textField.text = ""
        }
        
        return true
    }
    
    // MARK: - UITextFieldDelegate Protocol Reference
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case let textField where textField == rootView.goodsNameText:
            rootView.goodsQuantityText.becomeFirstResponder()
            return true
            
        case let textField where textField == rootView.goodsQuantityText:
            checkCharacterValues(textField)
            rootView.goodsPriceText.becomeFirstResponder()
            
            return true
            
        case let textField where textField == rootView.goodsPriceText:
            checkCharacterValues(textField)
            return !rootView.goodsPriceText.endEditing(true)
            
        default:
            return true
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case let textField where textField == rootView.goodsNameText:
            return true
            
        case let textField where textField == rootView.goodsQuantityText:
            return checkCharacterValues(textField)

        case let textField where textField == rootView.goodsPriceText:
            return checkCharacterValues(textField)
            
        default:
            return true
        }
    }
    
}

