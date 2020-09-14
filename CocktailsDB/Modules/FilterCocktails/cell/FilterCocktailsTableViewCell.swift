//
//  FilterCocktailsTableViewCell.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

class FilterCocktailsTableViewCell: BaseTableViewCell {
    
    public enum Consts {
        enum Layout {
            static let customNavigationHeightConstraint: CGFloat = 70.0
        }
    }
    
    private lazy var mainCellContentView = UIView()
    private lazy var filterNameLabel = UILabel()
    private lazy var checkMarkImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setup()
    }
    
    override class func height() -> CGFloat {
        return 65.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    public func setupModel(_ filtersName: FilterViewModel) {
        if let category = filtersName.drinkCategory {
            self.filterNameLabel.text = category
        }
        
        self.checkMarkImageView.isHidden = !filtersName.isSelected
    }
    
    private func setup() {
        self.setupSubviews()
        self.setupStyle()
        self.setupAutolayout()
    }
    
    private func setupSubviews() {
        self.selectionStyle = .none
        
        self.mainCellContentView.addSubview(self.filterNameLabel)
        self.mainCellContentView.addSubview(self.checkMarkImageView)
        
        addSubview(self.mainCellContentView)
    }
    
    private func setupStyle() {
        self.filterNameLabel.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        self.filterNameLabel.font = UIFont.normal(size: 14.0)
        
        self.checkMarkImageView.image = UIImage(named: "blackCheckMarkSelected")
        self.checkMarkImageView.contentMode = .scaleAspectFit
    }
    
    private func setupAutolayout() {
        self.mainCellContentView.translatesAutoresizingMaskIntoConstraints = false
        self.filterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.checkMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mainCellContentView.topAnchor.constraint(equalTo: topAnchor),
            self.mainCellContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.mainCellContentView.rightAnchor.constraint(equalTo: rightAnchor),
            self.mainCellContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.filterNameLabel.centerYAnchor.constraint(equalTo: self.mainCellContentView.centerYAnchor),
            self.filterNameLabel.leadingAnchor.constraint(equalTo: self.mainCellContentView.leadingAnchor, constant: 35.0),
            self.filterNameLabel.trailingAnchor.constraint(equalTo: self.checkMarkImageView.trailingAnchor, constant: -20.0),
            
            self.checkMarkImageView.widthAnchor.constraint(equalToConstant: 20.0),
            self.checkMarkImageView.heightAnchor.constraint(equalToConstant: 20.0),
            self.checkMarkImageView.centerYAnchor.constraint(equalTo: self.mainCellContentView.centerYAnchor),
            self.checkMarkImageView.trailingAnchor.constraint(equalTo: self.mainCellContentView.trailingAnchor, constant: -35.0)
        ])
    }
}
