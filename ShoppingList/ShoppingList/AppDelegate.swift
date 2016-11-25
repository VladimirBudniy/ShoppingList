//
//  AppDelegate.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/22/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import UIKit
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        MagicalRecord.setupCoreDataStackWithStoreNamed("ShoppingList")
        let window = UIWindow.window()
        let navigationController = UINavigationController()
        let viewController = ShoppingListViewController.controllerFromNib()
        
        navigationController.pushViewController(viewController as! ShoppingListViewController, animated: true)
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
      
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
      
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }
}

