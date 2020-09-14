//
//  MainCocktailHeaderView.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class MainCocktailHeaderView: BaseTableViewHeaderFooterView {

    private enum Consts {
        enum Layout {
            static let titleLabelLeadingConstraint: CGFloat = 20.0
        }
    }
    
    private lazy var mainContentHeaderView = UIView()
    
    private lazy var titleLabel = UILabel()
    
    public var titleString: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.setup()
    }
    
    override class func height() -> CGFloat {
        return 20.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        self.setupSubviews()
        self.setupStyle()
        self.setupAutolayout()
    }
    
    private func setupSubviews() {
        self.mainContentHeaderView.addSubview(self.titleLabel)
        addSubview(self.mainContentHeaderView)
    }

    private func setupStyle() {
        self.mainContentHeaderView.backgroundColor = .white
        
        self.titleLabel.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        self.titleLabel.font = UIFont.normal(size: 14.0)
    }
    
    private func setupAutolayout() {
        self.mainContentHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mainContentHeaderView.topAnchor.constraint(equalTo: topAnchor),
            self.mainContentHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.mainContentHeaderView.rightAnchor.constraint(equalTo: rightAnchor),
            self.mainContentHeaderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: self.mainContentHeaderView.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.mainContentHeaderView.leadingAnchor, constant: Consts.Layout.titleLabelLeadingConstraint)
        ])
    }
    
}

