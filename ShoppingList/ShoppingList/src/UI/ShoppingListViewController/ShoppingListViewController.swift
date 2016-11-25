//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit
import MagicalRecord

class ShoppingListViewController: UIViewController, ViewControllerRootView, PuchasesList, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Accessors
    
    typealias RootViewType = ShoppingListView
    
    var tableView: UITableView {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.addBarButtons()
        
        self.tableView.editing = false
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private
    
    func addBarButtons() {
        navigationItem.rightButtonSystemItem(.Add, target: self, action: #selector(ShoppingListViewController.purchaseViewController))
        navigationItem.leftButtonСorrectionItems(self, actionEdit: #selector(ShoppingListViewController.startEditing), actionRemoveAll: #selector(ShoppingListViewController.removeAllObjects))
    }
    
    func purchaseViewController() {
        let viewController = PurchaseViewController.controllerFromNib()
        navigationController?.pushViewController(viewController as! PurchaseViewController, animated: true)
    }
    
    func startEditing() {
        self.tableView.editing = !self.tableView.editing
    }
    
    func removeAllObjects() {
        removeAllObjectsFromDatabase()
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return puchasesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellFromNibWithClass(ShoppingListCell) as! ShoppingListCell
        cell.fillWithObject(puchasesList[indexPath.row] as! Purchase)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            removeObjectFromDatabaseAtIndex(indexPath.row)
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}
