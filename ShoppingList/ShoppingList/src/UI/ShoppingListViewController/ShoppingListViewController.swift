//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit
import MagicalRecord

class ShoppingListViewController: UIViewController, ViewControllerRootView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Accessors
    
    typealias RootViewType = ShoppingListView
    
    var shoppingList: NSArray {
        get {
            return Purchase.MR_findAllSortedBy("date", ascending: true)!
        }
    }
    
    var tableView: UITableView {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCellWithIdentifier(ShoppingListCell.className())
        self.addBarButtons()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.tableView.editing = false
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private
    
    private func registerCellWithIdentifier(identifier: String) {
        self.tableView.registerNib(UINib(nibName: identifier, bundle: nil),
                                   forCellReuseIdentifier: identifier)
    }
    
    
    private func addBarButtons() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Add,
                                                                      target: self,
                                                                      action: #selector(ShoppingListViewController.purchaseViewController))
        
        self.navigationItem.leftButtonСorrectionItems(self,
                                                       actionEdit: #selector(ShoppingListViewController.startEditing),
                                                       actionRemoveAll: #selector(ShoppingListViewController.removeAllObjects))
    }
    
    func purchaseViewController() {
        let viewController = PurchaseViewController(purchase: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func startEditing() {
        self.tableView.editing = !self.tableView.editing
    }
    
    func removeAllObjects() {
        MagicalRecord.saveWithBlock({context in
            for Purchase in self.shoppingList {
                Purchase.MR_deleteEntityInContext(context)
            }
            }, completion: {(succes, error) in
                if succes {
                    self.tableView.reloadData()
                }
                
                if (error != nil) {
                    print(ErrorType)
                }
        })
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ShoppingListCell.className()) as! ShoppingListCell
        let object = self.shoppingList[indexPath.row] as! Purchase
        cell.fillWithObject(object)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            MagicalRecord.saveWithBlock({ context in
                let purchase = self.shoppingList[indexPath.row]
                purchase.MR_deleteEntityInContext(context)
                }, completion: { (succes, error) in
                    if succes == true {
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
                    }
            })
        }
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let viewController = PurchaseViewController.init(purchase: self.shoppingList[indexPath.row] as? Purchase)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
