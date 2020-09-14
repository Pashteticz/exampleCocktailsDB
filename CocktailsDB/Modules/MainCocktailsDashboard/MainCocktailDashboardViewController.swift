//
//  MainCocktailDashboardViewController.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 11.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol UpdateListOfFiltersDelegate: class {
    func setNewFilters(_ filters: [String])
}

protocol MainViewCocktailDashboardProtocol: class {
    func hideHUD()
    func showHUD()
    func updateListOfFilters(_ ds: [DrinkListViewModel])
    func finishedPaginationFetch(_ ds: [DrinkListViewModel])
    func noDataForPagination()
}

class MainCocktailDashboardViewController: BaseViewController, MainViewCocktailDashboardProtocol, ViewController {

    public enum Consts {
        enum Layout {
            static let customNavigationHeightConstraint: CGFloat = 80.0
        }
    }
    
    private enum FetchinMoreStates {
        case yes, none
    }
    
    private lazy var customNavigationView = UIView()
    private lazy var mainCocktailNavigationLabel = UILabel()
    private lazy var filterNavigationButton = UIButton(type: .custom)
    
    private lazy var tableView = UITableView()
    
    private lazy var hud = JGProgressHUD(style: .dark)
    
    private var fetchingMore: FetchinMoreStates = .none
        
    var presenter: MainCocktailDashboardPresenter?

    private var currentDataSource: [DrinkListViewModel] = []
    
    private var listOfFilters = [String]()
    private var currentFilteredInvalidFilters = [String]()
    
    private var isDataForPaginationFinished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure(self)
        self.setup()
        self.presenter?.getListOfDrinksByFilter(listOfFilters)
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
    
    func updateListOfFilters(_ ds: [DrinkListViewModel]) {
        self.currentDataSource = ds
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func finishedPaginationFetch(_ ds: [DrinkListViewModel]) {
        self.currentDataSource = ds
        
        self.fetchingMore = .none
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func noDataForPagination() {
        self.isDataForPaginationFinished = true
        let ac = UIAlertController(title: "No Data", message: "Sorry, there is no new data".localized, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            ac.dismiss(animated: true, completion: nil)
        }

        ac.addAction(okAction)

        self.present(ac, animated: true, completion: nil)
    }

    private func setup() {
        self.setupSubviews()
        self.setupLocalization()
        self.setupStyle()
        self.setupAutolayout()
        self.setupActions()
    }
    
    private func setupSubviews() {
        self.navigationController?.navigationBar.isHidden = true
        
        self.customNavigationView.addSubview(self.mainCocktailNavigationLabel)
        self.customNavigationView.addSubview(self.filterNavigationButton)
        self.view.addSubview(self.customNavigationView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = Consts.Layout.customNavigationHeightConstraint
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.register(MainCocktailTableViewCell.self, forCellReuseIdentifier: MainCocktailTableViewCell.identifier())
        
        self.tableView.register(MainCocktailHeaderView.self, forHeaderFooterViewReuseIdentifier: MainCocktailHeaderView.identifier())
        
        self.view.addSubview(self.tableView)
    }
  
    private func setupLocalization() {
        self.mainCocktailNavigationLabel.text = "Drinks".localized
    }
    
    private func setupStyle() {
        self.view.backgroundColor = .white
        
        self.customNavigationView.backgroundColor = .white
        self.customNavigationView.addShadow()
        
        self.mainCocktailNavigationLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.mainCocktailNavigationLabel.font = UIFont.normal(size: 24.0)
        
        self.filterNavigationButton.setImage(UIImage(named: "blackFilter"), for: .normal)
        self.filterNavigationButton.imageView?.contentMode = .scaleAspectFit
    }
    
    private func setupAutolayout() {
        self.customNavigationView.translatesAutoresizingMaskIntoConstraints = false
        self.mainCocktailNavigationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.filterNavigationButton.translatesAutoresizingMaskIntoConstraints = false

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.customNavigationView.heightAnchor.constraint(equalToConstant: Consts.Layout.customNavigationHeightConstraint),
            self.customNavigationView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0),
            self.customNavigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            self.customNavigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            
            self.mainCocktailNavigationLabel.leadingAnchor.constraint(equalTo: self.customNavigationView.leadingAnchor, constant: 30.0),
            self.mainCocktailNavigationLabel.centerYAnchor.constraint(equalTo: self.customNavigationView.centerYAnchor),
            self.mainCocktailNavigationLabel.trailingAnchor.constraint(equalTo: self.filterNavigationButton.trailingAnchor, constant: -10.0),
            
            self.filterNavigationButton.heightAnchor.constraint(equalToConstant: 30.0),
            self.filterNavigationButton.widthAnchor.constraint(equalToConstant: 30.0),
            self.filterNavigationButton.centerYAnchor.constraint(equalTo: self.customNavigationView.centerYAnchor),
            self.filterNavigationButton.trailingAnchor.constraint(equalTo: self.customNavigationView.trailingAnchor, constant: -20.0),
            
            self.tableView.topAnchor.constraint(equalTo: self.customNavigationView.bottomAnchor, constant: 25.0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0)
        ])
    }
    
    private func setupActions() {
        self.filterNavigationButton.addTarget(self, action: #selector(filterNavigationButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func filterNavigationButtonClicked() {
        self.currentFilteredInvalidFilters = []
        self.presenter?.pushToFilter(self.listOfFilters)
    }
    
}

// MARK: - MainCocktailDashboardViewController -

// MARK: - UITableViewDelegate

extension MainCocktailDashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainCocktailTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MainCocktailHeaderView.height()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = self.currentDataSource[section]
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainCocktailHeaderView.identifier())
        
        if let view = view as? MainCocktailHeaderView {
            if let sectionName = sectionModel.sectionName {
                view.titleString = sectionName
            }
        }
        
        return view
    }
    
}

// MARK: - UITableViewDataSource

extension MainCocktailDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.currentDataSource[section]
        return section.items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCocktailTableViewCell.identifier(), for: indexPath) as! MainCocktailTableViewCell
        
        let section = self.currentDataSource[indexPath.section]
        let currentModel = section.items[indexPath.row]
        
        cell.displayImage(nil)
        cell.isDownloading = true
        self.downloaWithIndexPath(indexPath, currentModel.strDrinkThumb)
        
        cell.setupModel(currentModel)
        
        return cell
    }
    
    private func downloaWithIndexPath(_ indexPath: IndexPath, _ url: String?) {
        guard let url = URL(string: url ?? "") else { return }
        
        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let strongSelf = self else { return }
                
                if let data = data {
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        if let cell = strongSelf.tableView.cellForRow(at: indexPath) as? MainCocktailTableViewCell {
                            cell.displayImage(image)
                            cell.isDownloading = false
                        } 
                    }
                }
            }.resume()
        }
    }
}


// MARK: UIScrollViewDidScroll

extension MainCocktailDashboardViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !self.isDataForPaginationFinished {
                if self.fetchingMore != .yes {
                    self.fetchingMore = .yes
                    self.presenter?.makePaginationFetch(self.currentFilteredInvalidFilters)
                }
            }
        }
    }
}

// MARK: - Update Filters Delegate

extension MainCocktailDashboardViewController: UpdateListOfFiltersDelegate {
    func setNewFilters(_ filters: [String]) {
        self.listOfFilters = filters
               
        for (_ , items) in filters.enumerated() {
            if !items.contains(" ") && !items.contains("/") {
                self.currentFilteredInvalidFilters.append(items)
            }
        }

        self.currentDataSource = []
        self.isDataForPaginationFinished = false
        self.fetchingMore = .none
        self.presenter?.removeCurrentInteractorDataSource()
        self.presenter?.getListOfDrinksByFilter(self.currentFilteredInvalidFilters)
    }
}
