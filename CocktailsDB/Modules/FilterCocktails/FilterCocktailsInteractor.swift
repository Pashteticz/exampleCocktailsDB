//
//  FilterCocktailsInteractor.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

protocol FilterCocktailsInteractorProtocl {
    func getListOfFilters(_ completion: @escaping ((Error?,[FilterViewModel]?) -> Void))
}

class FilterCocktailsInteractor: FilterCocktailsInteractorProtocl {
    private let presenter: FilterCocktailPresenter
    
    private let networkService = RequestBuilder.sharedInstance
    
    init(presenter: FilterCocktailPresenter) {
        self.presenter = presenter
    }
    
    func getListOfFilters(_ completion: @escaping ((Error?,[FilterViewModel]?) -> Void)) {
        self.networkService.getListOfFilter { (result) in
            switch result {
            case let .success(model):
                
                var dataSource: [FilterViewModel] = []
                if let drinks = model.drinks {
                    for (_, networkModel) in drinks.enumerated() {
                        if let category = networkModel.strCategory {
                            dataSource.append(FilterViewModel.init(category))
                        }
                    }
                }
                
                completion(nil,dataSource)
            case let .error(error):
                print("Error:",error.localizedDescription)
                completion(error,nil)
            }
        }
    }
}
