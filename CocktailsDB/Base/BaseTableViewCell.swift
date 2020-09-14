//
//  BaseTableViewCell.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func height() -> CGFloat {
        return 44
    }
}
