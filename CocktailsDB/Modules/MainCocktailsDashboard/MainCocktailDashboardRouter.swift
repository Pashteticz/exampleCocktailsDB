//
//  MainCocktailDashboardRouter.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

protocol MainCocktailRouterProtocl {
    func showFilterScreen(_ listOfFilters: [String])
}

class MainCocktailRouter: Router, MainCocktailRouterProtocl {
   
    var currentDelegate: MainCocktailDashboardViewController?
    
    override init(rootController: UINavigationController) {
        super.init(rootController: rootController)
    }
    
    func showFilterScreen(_ listOfFilters: [String]) {
        let viewController = FilterCocktailsViewController()
        
        if let currentVc = self.currentDelegate {
            viewController.delegate = currentVc
        }
        
        if listOfFilters.count > 0 {
            viewController.selectedFilters = listOfFilters
        }
        
        pushViewController(viewController)
    }
}
