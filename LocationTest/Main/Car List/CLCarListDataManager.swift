//
//  CLCarListDataManager.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/4/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.

//

import Foundation

class CLCarListDataManager: CLCarListDataManagerInputProtocol {
    weak var interactor: CLCarListDataManagerOutputProtocol?
    func retrieveCarList(_ maxId: Int64, fetchIfNeeded: Bool) {
        let results = Array(CoreDataManager.realm
            .objects(CMCar.self)
            .filter("id < \(maxId)")
            .sorted(byKeyPath: "id", ascending: false)
            .prefix(10))
        if fetchIfNeeded && results.count == 0 {
            CoreDataManager.fetchData { [weak self] () in
                self?.retrieveCarList(maxId, fetchIfNeeded: false)
            }
        } else {
            DispatchQueue.main.async { [weak self] () in
                self?.interactor?.didRetrieveCars(cars: results)
            }
        }
    }
}
