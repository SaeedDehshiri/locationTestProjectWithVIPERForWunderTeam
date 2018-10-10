//
//  CLCarListViewController.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/1/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit

class CLCarListViewController: CBViewController {
    
    var presenter: CLCarListPresenterProtocol?
    var cars: [CMCar] = []
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        title = String.localized("CL.Tab.CarList.Title")
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = self.view.bounds
        tableView.separatorStyle = .none
        
    }
    
}

extension CLCarListViewController: CLCarListViewControllerProtocol {
    
    func addCars(count: Int, refreshed: Bool) {
        if refreshed {
            tableView.reloadData()
        } else {
            tableView.beginUpdates()
            var indexPaths: [IndexPath] = []
            for i in 0..<count {
                indexPaths.append(.init(row: cars.count - i - 1, section: 0))
            }
            tableView.insertRows(at: indexPaths.reversed(), with: .fade)
            tableView.endUpdates()
        }
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showNoResult() {
        
    }
    
}

extension CLCarListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layout.carListCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CLCarListCell
            = (tableView.dequeueReusableCell(withIdentifier: "CL.Cell.CarList") as? CLCarListCell) ?? CLCarListCell(reuseIdentifier: "CL.Cell.CarList")
        cell.load(car: cars[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height + Layout.carListCellHeight + 10 >= scrollView.contentSize.height {
            
            presenter?.loadMore()
            
        }
    }
    
}
