//
//  FilterCocktailsPresenter.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

protocol FilterCocktalPresenterProtocol {
    func popToMainCocktailDashboard()
    func getListOfFilter()
}

extension FilterCocktalPresenterProtocol {
    func popToMainCocktailDashboard() { }
}

class FilterCocktailPresenter: FilterCocktalPresenterProtocol {
    weak var view: MainViewFilterCocktails?
    
    var interactor: FilterCocktailsInteractor!
    var router: FilterCocktailRouter!
    
    init(viewController: MainViewFilterCocktails) {
        self.view = viewController
    }
    
    func getListOfFilter() {
        self.view?.showHUD()
        self.interactor.getListOfFilters { [weak self] (error, model) in
            guard let strongSelf = self else { return }
            
            strongSelf.view?.hideHUD()
            
            if let error = error {
                print("Error:", error.localizedDescription)
            }
            
            if let ds = model {
                strongSelf.view?.updateListOfFilters(ds)
            }
        }
    }
    
    func popToMainCocktailDashboard() {
        router.popToMainCocktailDashboard()
    }
}
