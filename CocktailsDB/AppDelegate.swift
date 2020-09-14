//
//  AppDelegate.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private lazy var navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.navigationController
        self.navigationController.setViewControllers([MainCocktailDashboardViewController()], animated: true)
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

