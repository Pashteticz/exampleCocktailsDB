//
//  FilterViewModel.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class FilterViewModel: NSObject {
    var drinkCategory: String?
    var isSelected: Bool = false
    
    init(_ category: String) {
        self.drinkCategory = category
    }
}
