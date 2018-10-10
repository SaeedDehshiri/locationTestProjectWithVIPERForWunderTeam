//
//  CLCarDetailsProtocols.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 9/30/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//
import UIKit

protocol CLCarListViewControllerProtocol: class {
    var presenter: CLCarListPresenterProtocol? { get set }
    var cars: [CMCar] { get set }
    var tableView: UITableView! { get set }
    func addCars(count: Int, refreshed: Bool) 
    func showError()
    func showLoading()
    func hideLoading()
    func showNoResult()
}

protocol CLCarListWireFrameProtocol: class {
    static func createModule() -> UIViewController
}

protocol CLCarListPresenterProtocol: class {
    var view: CLCarListViewControllerProtocol? { get set }
    var interactor: CLCarListInteractorInputProtocol? { get set }
    func viewDidLoad()
    func loadMore()
    func showCarDetails(forCar car: CMCar)
}

protocol CLCarListInteractorOutputProtocol: class {
    func didRetrieveCars(_ cars: [CMCar], isRefreshed: Bool)
    func onError()
}

protocol CLCarListInteractorInputProtocol: class {
    var presenter: CLCarListInteractorOutputProtocol? { get set }
    var datamanager: CLCarListDataManagerInputProtocol? { get set }
    func retrieveCarList(_ maxId: Int64)
}

protocol CLCarListDataManagerOutputProtocol: class {
    func didRetrieveCars(cars: [CMCar])
}

protocol CLCarListDataManagerInputProtocol: class {
    var interactor: CLCarListDataManagerOutputProtocol? { get set }
    func retrieveCarList(_ maxId: Int64, fetchIfNeeded: Bool)
}

