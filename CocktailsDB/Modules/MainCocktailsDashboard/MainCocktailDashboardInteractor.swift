//
//  MainCocktailDashboardInteractor.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

protocol MainCocktailDashboardInteractorProtocol {
    func setup()
    func pushToFilterScreen()
    func getListOfDrinksByFilter(_ completion: @escaping ((Error?,[DrinkListViewModel]?) -> Void))
    func makePaginationFetch(_ completion: @escaping ((Error?,[DrinkListViewModel]?) -> Void))
}

class MainCocktailDashboardInteractor: MainCocktailDashboardInteractorProtocol {
    
    private let presenter: MainCocktailDashboardPresenter
    
    private let networkService = RequestBuilder.sharedInstance
    
    private var currentPage = 1
    public var currentFilter = ""
    
    public var filters: [String] = []
    public var firstFilter = -1
    
    var currentDataSource: [DrinkListViewModel] = []
    
    init(presenter: MainCocktailDashboardPresenter) {
        self.presenter = presenter
    }
    
    func setup() { }
    
    func getListOfDrinksByFilter(_ completion: @escaping ((Error?,[DrinkListViewModel]?) -> Void)) {
        self.networkService.getDrinkListWithFilter(self.currentPage,self.currentFilter) { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            switch result {
            case let .success(model):
                
                strongSelf.setupDataSource(model) {
                    completion(nil,strongSelf.currentDataSource)
                }
                
            case let .error(error):
                print("Error:",error.localizedDescription)
                completion(error,nil)
            }
        }
    }
    
    private func setupDataSource(_ model: DrinkListNetworkModel, _ completion: @escaping () -> ()) {
        if let drinks = model.drinks {
            let ds = DrinkListViewModel()
            var isSectionExist = false
            
            for(_, networkModel) in drinks.enumerated() {
                ds.items.append(DrinksListItemViewModel.init(networkModel))
                ds.sectionName = self.currentFilter
            }
            
            for (_ , items) in self.currentDataSource.enumerated() {
                if items.sectionName == ds.sectionName {
                    items.items += ds.items
                    isSectionExist = true
                }
            }
            
            if !isSectionExist {
                self.currentDataSource.append(ds)
            }
            
        }
        
        completion()
    }
    
    func getListOfFilters(_ completion: @escaping () -> () ) {
        self.networkService.getListOfFilter { (result) in
            switch result {
            case let .success(model):
                
                if let drinks = model.drinks {
                    for (_, networkModel) in drinks.enumerated() {
                        
                        if let category = networkModel.strCategory {
                            if !category.contains(" ") && !category.contains("/") {
                                if !self.currentFilter.hasChars() {
                                    self.currentFilter = category
                                } else {
                                    self.filters.append(category)
                                }
                            }
                        }
                    }
                }
                
                completion()
            case let .error(error):
                print("Error:",error.localizedDescription)
            }
        }
    }
    
    func makePaginationFetch(_ completion: @escaping ((Error?,[DrinkListViewModel]?) -> Void)) {
        self.currentPage += 1
        
        if self.currentPage == 3 {
            self.currentPage = 1
            self.firstFilter += 1
            
            for (i,filterName) in self.filters.enumerated() {
                if !filterName.contains(" ") && !filterName.contains("/") {
                    if i == self.firstFilter {
                        self.currentFilter = filterName
                    }
                }
            }
        }
        
        if self.firstFilter >= self.filters.count {
            completion(nil,nil)
        } else {
            self.getListOfDrinksByFilter(completion)
        }
    }
    
    func pushToFilterScreen() {
        presenter.pushToFilter()
    }
}
