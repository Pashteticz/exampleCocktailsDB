//
//  FilterCocktailsRouter.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

protocol FilterCocktailProtocol {
    func popToMainCocktailDashboard()
}

class FilterCocktailRouter: Router, FilterCocktailProtocol {
    override init(rootController: UINavigationController) {
        super.init(rootController: rootController)
    }

    func popToMainCocktailDashboard() {
        popToRootViewController()
    }
}

