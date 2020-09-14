//
//  DrinksListViewModel.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class DrinkListViewModel: NSObject {
    var items: [DrinksListItemViewModel] = []
    var sectionName: String? = ""
}

class DrinksListItemViewModel: NSObject {
    var strDrink: String?
    var strDrinkThumb: String?
    var idDrink: String?
    
    init(_ networkModel: DrinkList) {
        self.strDrink = networkModel.strDrink
        self.strDrinkThumb = networkModel.strDrinkThumb
        self.idDrink = networkModel.idDrink
    }
}
