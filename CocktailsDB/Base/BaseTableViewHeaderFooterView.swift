//
//  BaseTableFooterView.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {

    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func height() -> CGFloat {
        return 0.0
    }
}
