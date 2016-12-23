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
    
    var tableView: UITableView {
        return self.rootView.tabelView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.edgesForExtendedLayout = .None // method for UIViewController
        self.registerCellWithIdentifier(ShoppingListCell.className())
        self.settingNavigationBar()
        self.tableView.contentInset.top = 60 // method for UITableView
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
    
    private func settingNavigationBar() {
        self.addBarButtons()
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.translucent = true
    }
    
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
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func startEditing() {
        self.tableView.editing = !self.tableView.editing
    }
    
    func removeAllObjects() {
        MagicalRecord.saveWithBlock({context in
            let array = Purchase.MR_findAllSortedBy("date", ascending: true, inContext: context)
            for purchase in array! {
                purchase.MR_deleteEntityInContext(context)
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
        let array = Purchase.MR_findAllSortedBy("date", ascending: true)
        return array!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ShoppingListCell.className()) as! ShoppingListCell
        let array = Purchase.MR_findAllSortedBy("date", ascending: true)
        let object = array![indexPath.row] as! Purchase
        cell.fillWithObject(object)
        
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            MagicalRecord.saveWithBlock({ context in
                let array = Purchase.MR_findAllSortedBy("date", ascending: true, inContext: context)
                let purchase = array![indexPath.row]
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
        let array = Purchase.MR_findAllSortedBy("date", ascending: true)
        let viewController = PurchaseViewController.init(purchase: array![indexPath.row] as? Purchase)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
