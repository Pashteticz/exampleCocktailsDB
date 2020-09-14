//
//  FilterCocktailsViewController.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 12.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol MainViewFilterCocktails: class {
    func showHUD()
    func hideHUD()
    func updateListOfFilters(_ dataSource: [FilterViewModel])
}

class FilterCocktailsViewController: BaseViewController, ViewController, MainViewFilterCocktails {

    public enum Consts {
        enum Layout {
            static let customNavigationHeightConstraint: CGFloat = 80.0
            static let tableViewCellHeight: CGFloat = 160.0
        }
    }
    
    private lazy var customNavigationView = UIView()
    private lazy var backNavigationButton = UIButton(type: .custom)
    private lazy var filterBackTitleLabel = UILabel()
    
    private lazy var tableView = UITableView()
    private lazy var applyButton = UIButton(type: .custom)
    
    private lazy var hud = JGProgressHUD(style: .dark)
    
    public var selectedFilters: [String] = []
    
    public var dataSource: [FilterViewModel] = []
  
    weak var delegate: UpdateListOfFiltersDelegate?
    
    var presenter: FilterCocktailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure(self)
        self.setup()
        self.getListOfFilters()
    }
    
    func showHUD() {
        DispatchQueue.main.async {
            self.hud.show(in: self.view, animated: true)
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            self.hud.dismiss(animated: true)
        }
    }
    
    func updateListOfFilters(_ dataSource: [FilterViewModel]) {
        self.dataSource = dataSource
        
        var isSelectedFilterEmpty = false
        
        if self.selectedFilters.count == 0 {
            isSelectedFilterEmpty = true
        }
        
        for (i, items) in self.dataSource.enumerated() {
            if let category = items.drinkCategory {
                if self.selectedFilters.contains(category) {
                    self.dataSource[i].isSelected = true
                } else if isSelectedFilterEmpty {
                    self.dataSource[i].isSelected = true
                    self.selectedFilters.append(category)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func getListOfFilters() {
        self.presenter?.getListOfFilter()
    }

    private func setup() {
        self.setupSubviews()
        self.setupLocalization()
        self.setupStyle()
        self.setupAutolayout()
        self.setupActions()
    }
    
    private func setupSubviews() {
        navigationController?.navigationBar.isHidden = true
        
        self.customNavigationView.addSubview(self.backNavigationButton)
        self.customNavigationView.addSubview(self.filterBackTitleLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = Consts.Layout.customNavigationHeightConstraint
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.register(FilterCocktailsTableViewCell.self, forCellReuseIdentifier: FilterCocktailsTableViewCell.identifier())
        
        self.view.addSubview(self.customNavigationView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.applyButton)
    }
    
    private func setupLocalization() {
        self.applyButton.setTitle("Apply".localized, for: .normal)
        self.filterBackTitleLabel.text = "Filters".localized
    }
    
    private func setupStyle() {
        self.view.backgroundColor = .white
        
        self.customNavigationView.backgroundColor = .white
        self.customNavigationView.addShadow()
        
        self.backNavigationButton.setImage(UIImage(named: "blackBackArrow"), for: .normal)
        self.filterBackTitleLabel.font = UIFont.normal(size: 24.0)
        self.filterBackTitleLabel.textColor = .black
        
        self.applyButton.backgroundColor = .black
        self.applyButton.setTitleColor(.white, for: .normal)
        self.applyButton.titleLabel?.font = UIFont.normal(size: 14.0)
    }
    
    private func setupAutolayout() {
        self.applyButton.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.customNavigationView.translatesAutoresizingMaskIntoConstraints = false
        self.backNavigationButton.translatesAutoresizingMaskIntoConstraints = false
        self.filterBackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.customNavigationView.heightAnchor.constraint(equalToConstant: Consts.Layout.customNavigationHeightConstraint),
            self.customNavigationView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0),
            self.customNavigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            self.customNavigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
                
            self.backNavigationButton.widthAnchor.constraint(equalToConstant: 30.0),
            self.backNavigationButton.heightAnchor.constraint(equalToConstant: 30.0),
            self.backNavigationButton.centerYAnchor.constraint(equalTo: self.customNavigationView.centerYAnchor),
            self.backNavigationButton.leadingAnchor.constraint(equalTo: self.customNavigationView.leadingAnchor, constant: 20.0),
            
            self.filterBackTitleLabel.centerYAnchor.constraint(equalTo: self.backNavigationButton.centerYAnchor),
            self.filterBackTitleLabel.leadingAnchor.constraint(equalTo: self.backNavigationButton.trailingAnchor, constant: 40.0),
            self.filterBackTitleLabel.trailingAnchor.constraint(equalTo: self.customNavigationView.trailingAnchor, constant: -10.0),

            self.tableView.topAnchor.constraint(equalTo: self.customNavigationView.bottomAnchor, constant: 25.0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            self.tableView.bottomAnchor.constraint(equalTo: self.applyButton.topAnchor, constant: -20.0),
            
            self.applyButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.applyButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            self.applyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            self.applyButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15.0)
        ])
    }
    
    private func setupActions() {
        self.applyButton.addTarget(self, action: #selector(applyFilterButtonClicked), for: .touchUpInside)
        self.backNavigationButton.addTarget(self, action: #selector(backNavigationButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func applyFilterButtonClicked() {
        for (_ ,items) in self.selectedFilters.enumerated() {
            print("LIST of fikters: ", items)
        }
        
        if self.selectedFilters.count == 0 {
            let ac = UIAlertController(title: "Error", message: "You should select one or more filters".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                ac.dismiss(animated: true, completion: nil)
            }
            
            ac.addAction(okAction)
            
            self.present(ac, animated: true, completion: nil)
        } else {
            self.delegate?.setNewFilters(self.selectedFilters)
            self.presenter?.popToMainCocktailDashboard()
        }
    }
    
    @objc func backNavigationButtonClicked() {
        self.presenter?.popToMainCocktailDashboard()
    }
    
}

// MARK: - MainCocktailDashboardViewController -

// MARK: - UITableViewDelegate

extension FilterCocktailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FilterCocktailsTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row]
        model.isSelected = !model.isSelected
        
        if let selectedCategory = model.drinkCategory {
            if self.selectedFilters.contains(selectedCategory) {
                if let index = self.selectedFilters.firstIndex(of: selectedCategory) {
                    self.selectedFilters.remove(at: index)
                }
            } else {
                self.selectedFilters.append(selectedCategory)
            }
        }
        
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension FilterCocktailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCocktailsTableViewCell.identifier(), for: indexPath) as! FilterCocktailsTableViewCell
        
        let ds = self.dataSource[indexPath.row]
        cell.setupModel(ds)
        
        return cell
    }
}

