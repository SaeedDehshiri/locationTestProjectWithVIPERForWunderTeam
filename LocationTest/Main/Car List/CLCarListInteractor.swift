//
//  CLCarListInteractor.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/4/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import Foundation

class CLCarListInteractor: CLCarListInteractorInputProtocol {
    weak var presenter: CLCarListInteractorOutputProtocol?
    var datamanager: CLCarListDataManagerInputProtocol?
    private var isRefreshing: Bool = false
    func retrieveCarList(_ maxId: Int64) {
        isRefreshing = maxId == Int.max
        datamanager?.retrieveCarList(maxId, fetchIfNeeded: true)
    }
}
extension CLCarListInteractor: CLCarListDataManagerOutputProtocol {
    func didRetrieveCars(cars: [CMCar]) {
        presenter?.didRetrieveCars(cars, isRefreshed: isRefreshing)
        isRefreshing = false
    }
}
