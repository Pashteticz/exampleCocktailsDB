//
//  MainCocktailTableViewCell.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit

struct MainCocktailTableViewCellInteractor {
    var indexPath: IndexPath?
    var dataTask: URLSessionDataTask?
}

class MainCocktailTableViewCell: BaseTableViewCell {
    
    public enum Consts {
        enum Layout {
            static let customNavigationHeightConstraint: CGFloat = 70.0
        }
    }
    
    private lazy var mainCocktailFlowView = UIView()
    
    private lazy var cocktailImageView = UIImageView()
    private lazy var cocktailNameLabel = UILabel()
    
    private lazy var imageDownloadingActivityIndicator = UIActivityIndicatorView()
    
    var isDownloading: Bool {
        get {
            return imageDownloadingActivityIndicator.isAnimating
        }
        set {
            if newValue {
                self.imageDownloadingActivityIndicator.isHidden = false
                self.imageDownloadingActivityIndicator.startAnimating()
            } else {
                self.imageDownloadingActivityIndicator.isHidden = true
                self.imageDownloadingActivityIndicator.stopAnimating()
            }
        }
    }
    
    var interactor = MainCocktailTableViewCellInteractor()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setup()
    }
    
    override class func height() -> CGFloat {
        return 140.0
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    public func setupModel(_ model: DrinksListItemViewModel) {
        if let drinksName = model.strDrink {
            self.cocktailNameLabel.text = drinksName
        }
    }
    
    public func displayImage(_ image: UIImage?) {
        self.cocktailImageView.image = image
    }
    
    private func setup() {
        self.setupSubviews()
        self.setupStyle()
        self.setupAutolayout()
    }
    
    private func setupSubviews() {
        self.selectionStyle = .none
        
        self.cocktailImageView.addSubview(self.imageDownloadingActivityIndicator)
        self.mainCocktailFlowView.addSubview(self.cocktailImageView)
        self.mainCocktailFlowView.addSubview(self.cocktailNameLabel)
        
        addSubview(self.mainCocktailFlowView)
    }
 
    private func setupStyle() {
        self.cocktailNameLabel.font = UIFont.normal(size: 16.0)
        self.cocktailNameLabel.minimumScaleFactor = 0.4
        self.cocktailNameLabel.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
    }
    
    private func setupAutolayout() {
        self.cocktailImageView.translatesAutoresizingMaskIntoConstraints = false
        self.cocktailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainCocktailFlowView.translatesAutoresizingMaskIntoConstraints = false
        self.imageDownloadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mainCocktailFlowView.topAnchor.constraint(equalTo: topAnchor),
            self.mainCocktailFlowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.mainCocktailFlowView.rightAnchor.constraint(equalTo: rightAnchor),
            self.mainCocktailFlowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.cocktailImageView.heightAnchor.constraint(equalToConstant: 100.0),
            self.cocktailImageView.widthAnchor.constraint(equalToConstant: 100.0),
            self.cocktailImageView.centerYAnchor.constraint(equalTo: self.mainCocktailFlowView.centerYAnchor),
            self.cocktailImageView.leadingAnchor.constraint(equalTo: self.mainCocktailFlowView.leadingAnchor, constant: 20.0),
            
            self.imageDownloadingActivityIndicator.centerYAnchor.constraint(equalTo: self.cocktailImageView.centerYAnchor),
            self.imageDownloadingActivityIndicator.centerXAnchor.constraint(equalTo: self.cocktailImageView.centerXAnchor),
            
            self.cocktailNameLabel.leadingAnchor.constraint(equalTo: self.cocktailImageView.trailingAnchor, constant: 20.0),
            self.cocktailNameLabel.centerYAnchor.constraint(equalTo: self.cocktailImageView.centerYAnchor),
            self.cocktailNameLabel.trailingAnchor.constraint(equalTo: self.mainCocktailFlowView.trailingAnchor, constant: -20.0),
        ])
    }
}
