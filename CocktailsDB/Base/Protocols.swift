//
//  Protocols.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import Foundation
import UIKit

protocol ViewController where Self: UIViewController {}

extension ViewController {
    func configure(_ viewController: ViewController) {
        switch viewController {
        case is MainCocktailDashboardViewController:
            MainCocktailDashboardConfigurator.sharedInstance.configure(with: viewController)
        case is FilterCocktailsViewController:
            FilterCocktailConfigurator.sharedInstance.configure(with: viewController)
        default:
            break
        }
    }
}
