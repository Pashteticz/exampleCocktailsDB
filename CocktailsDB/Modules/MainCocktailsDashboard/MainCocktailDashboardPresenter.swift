//
//  MainCocktailDashboardPresenter.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

protocol MainCocktailDashboardPresenterProtocol {
    func pushToFilter(_ listOfFilters: [String])
    func getListOfDrinksByFilter(_ listOfFilters: [String])
    func makePaginationFetch(_ listOfFilters: [String])
}

extension MainCocktailDashboardPresenterProtocol {
    func pushToFilter() {}
}

class MainCocktailDashboardPresenter: MainCocktailDashboardPresenterProtocol {

    weak var view: MainViewCocktailDashboardProtocol?
    
    var router: MainCocktailRouter!
    var interactor: MainCocktailDashboardInteractor!
    
    init(viewController: MainCocktailDashboardViewController) {
        self.view = viewController
    }
    
    func removeCurrentInteractorDataSource() {
        self.interactor.currentDataSource = []
    }
    
    func getListOfDrinksByFilter(_ listOfFilters: [String]) {
        if listOfFilters.count == 0 {
            self.interactor.getListOfFilters { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.getListRequest()
            }
        } else {
            if self.interactor.filters != listOfFilters {
                for (_ , filterName) in listOfFilters.enumerated() {
                    if !filterName.contains(" ") && !filterName.contains("/") {
                        self.interactor.currentFilter = filterName
                        self.interactor.firstFilter = 0
                        break
                    }
                }
            }
            
            self.interactor.filters = listOfFilters
            self.getListRequest()
        }
    }
    
    func getListRequest() {
        self.view?.showHUD()
        
        self.interactor.getListOfDrinksByFilter { [weak self] (error, model) in
            guard let strongSelf = self else { return }
            
            strongSelf.view?.hideHUD()
            
            if let error = error {
                print("Error :", error.localizedDescription)
            }
            
            if let ds = model {
                strongSelf.view?.updateListOfFilters(ds)
            }
        }
    }

    func makePaginationFetch(_ listOfFilters: [String]) {
        if listOfFilters.count > 0 {
            self.interactor.filters = listOfFilters
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.interactor.makePaginationFetch { [weak self] (error, model) in
                guard let strongSelf = self else { return }
                
                if error == nil, model == nil {
                    strongSelf.view?.noDataForPagination()
                }
                
                if let error = error {
                    print("Error Sory: ", error.localizedDescription)
                }
                
                if let ds = model {
                    strongSelf.view?.finishedPaginationFetch(ds)
                }
            }
        }
    }

    func pushToFilter(_ listOfFilters: [String]) {
        router.showFilterScreen(listOfFilters)
    }
}
