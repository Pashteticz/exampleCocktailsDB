//
//  FilterListNetworkModel.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class FilterListNetworkModel: Codable {
    var drinks: [FilterList]?
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}

class FilterList: Codable {
    var strCategory: String?
    
    enum CodingKeys: String, CodingKey {
        case strCategory
    }
}
