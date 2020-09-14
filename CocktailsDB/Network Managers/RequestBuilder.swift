//
//  RequestBuilder.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import Foundation
import UIKit

protocol RequestBuilderProtocol {
    func getDrinkListWithFilter(_ currentPage: Int, _ currentFilter: String, completion: @escaping DrinksHanlder)
    func getListOfFilter(_ completion: @escaping FiltersHanlder)
}

enum Result<T> {
    case success(T)
    case error(Error)
}

// MARK: - Handlers

typealias DrinksHanlder = (Result<DrinkListNetworkModel>) -> ()

typealias FiltersHanlder = (Result<FilterListNetworkModel>) -> ()

class RequestBuilder: RequestBuilderProtocol {
  
    static let sharedInstance = RequestBuilder()
    
    private init() { }
    
    // MARK: - Requests -

    // MARK: - Drinks List
    
    func getDrinkListWithFilter(_ currentPage: Int, _ currentFilter: String, completion: @escaping DrinksHanlder) {

        RequestManager.shared.request(url: DrinkPath.Request.filter.url(currentPage: currentPage) + "\(currentFilter)", parameters: nil) { [weak self] (result) in
            guard let strongSelf = self else { return }
            
             strongSelf.getListOfFiltersResponse(result, completion)
        }
    }
    
    // MARK: - Get drinks list parser
    
    private func getListOfFiltersResponse(_ result: ResultRequest, _ completion: @escaping DrinksHanlder) {
        
        switch result {
        case let .success(response):
            do {
                let result = try JSONDecoder().decode(DrinkListNetworkModel.self, from: response)
                
                completion(.success(result))
            } catch let error {
                completion(.error(error))
            }
        case let .error(error):
            completion(.error(error))
        }
    }
    
    // MARK: - Filters List

    func getListOfFilter(_ completion: @escaping FiltersHanlder) {
        RequestManager.shared.request(url: FilterPath.Request.list.url(), parameters: nil) { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.getListOfFiltersResponse(result, completion)
        }
    }
    
    // MARK: - Get Filters list parser
   
    private func getListOfFiltersResponse(_ result: ResultRequest, _ completion: @escaping FiltersHanlder) {
        switch result {
        case let .success(response):
            do {
                let result = try JSONDecoder().decode(FilterListNetworkModel.self, from: response)

                completion(.success(result))
            } catch let error {
                completion(.error(error))
            }
        case let .error(error):
            completion(.error(error))
        }
    }
}
