//
//  MainCocktailDashboardConfigurator.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

final class MainCocktailDashboardConfigurator {
    static let sharedInstance = MainCocktailDashboardConfigurator()
    
    private init() { }
    
    func configure(with viewcontroller: UIViewController) {
        guard let viewController = viewcontroller as? MainCocktailDashboardViewController else { return }
        
        let router = MainCocktailRouter(rootController: viewController.navigationController ?? UINavigationController())
        let presenter = MainCocktailDashboardPresenter(viewController: viewController)
        let interactor = MainCocktailDashboardInteractor(presenter: presenter)

        router.currentDelegate = viewController
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
    }
}
