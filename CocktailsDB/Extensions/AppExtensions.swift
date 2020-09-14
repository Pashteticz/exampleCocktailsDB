//
//  AppExtensions.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

// MARK: - UIFont

extension UIFont {
    class func normal(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size) }
}
// MARK: - UIView

extension UIView {
    func addShadow(_ isCenter: Bool = false) {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1.5
        self.layer.shadowRadius = 6.0
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 2.0)
    }
}

