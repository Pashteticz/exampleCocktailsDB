//
//  FilterCocktailsConfigurator.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

final class FilterCocktailConfigurator {
    static let sharedInstance = FilterCocktailConfigurator()
    
    private init () { }
    
    func configure(with viewcontroller: UIViewController) {
        guard let viewController = viewcontroller as? FilterCocktailsViewController else { return }
        
        let router = FilterCocktailRouter(rootController: viewController.navigationController ?? UINavigationController())
        let presenter = FilterCocktailPresenter(viewController: viewController)
        let interactor = FilterCocktailsInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
    }
}
