//
//  RequestPath.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Domains -

// MARk: - BaseURL

public enum BaseURL {
    static let domain = "https://www.thecocktaildb.com"
}

// MARK: - DrinkPath

public enum DrinkPath {
    static let endpoint = "/api/json/v"
    
    enum Request: String {
        case filter = "/1/filter.php?c="
        
        func url(currentPage: Int) -> String { return BaseURL.domain + DrinkPath.endpoint + "\(currentPage)" + rawValue }
    }
}

// MARK: - FilterPath

public enum FilterPath {
    static let endpoint = "/api/json/v1/1/list.php?c="
    
    enum Request: String {
        case list = "list"
        
        func url() -> String { return BaseURL.domain + FilterPath.endpoint + rawValue }
    }
}
