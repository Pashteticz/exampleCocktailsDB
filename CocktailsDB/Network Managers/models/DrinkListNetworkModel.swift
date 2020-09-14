//
//  DrinkListNetworkModel.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class DrinkListNetworkModel: Codable {
    var drinks: [DrinkList]?
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}

class DrinkList: Codable {
    var strDrink: String?
    var strDrinkThumb: String?
    var idDrink: String?
    
    enum CodingKeys: String, CodingKey {
        case strDrink
        case strDrinkThumb
        case idDrink
    }
}

