//
//  CLCarListPresenter.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/1/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import Foundation

class CLCarListPresenter: CLCarListPresenterProtocol {
    weak var view: CLCarListViewControllerProtocol?
    var interactor: CLCarListInteractorInputProtocol?
    var loading: Bool = false
    func viewDidLoad() {
        var maxId: Int = Int.max
        if view?.cars.last?.id != nil {
            maxId = view!.cars.last!.id
        }
        loading = true
        self.interactor?.retrieveCarList(Int64(maxId))
    }
    func showCarDetails(forCar car: CMCar) {
        // nothing here for now :)
    }
}

extension CLCarListPresenter: CLCarListInteractorOutputProtocol {
    func didRetrieveCars(_ cars: [CMCar], isRefreshed: Bool) {
        if isRefreshed {
            view?.cars = cars
        } else {
            view?.cars.append(contentsOf: cars)
        }
        view?.tableView.reloadData()
        // TODO - Fix the function below
        //view?.addCars(count: cars.count, refreshed: isRefreshed)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] () in
            self?.loading = false
        }
        
    }
    func loadMore() {
        if !loading {
            loading = true
            if let view = self.view {
                if let last = view.cars.last {
                    interactor?.retrieveCarList(Int64(last.id))
                }
            }
        }
    }
    func onError() {
        
    }
}
