//
//  CLCarMapDataManager.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/6/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import Foundation
import GoogleMaps

class CLCarMapDataManager {
    weak var interactor: CLCarMapDataManagerOutputProtocol?
}

extension CLCarMapDataManager: CLCarMapDataManagerInputProtocol {

    func retrieveCarsFor(camera: GMSCameraPosition, projection: GMSProjection) {
        //camera
        let results = Array(CoreDataManager.realm.objects(CMCar.self)).filter({ [weak self] (value) in
            return projection.contains(CLLocationCoordinate2D.init(latitude: value.lat,
                                                                   longitude: value.long))
        }).sorted { [weak self] (car1, car2) in
            let l1 = CLLocation(latitude: car1.lat, longitude: car1.long)
            let l2 = CLLocation(latitude: car2.lat, longitude: car2.long)
            let lm = CLLocation(latitude: camera.target.latitude, longitude: camera.target.longitude)
            return lm.distance(from: l1) < lm.distance(from: l2)
        }.prefix(30)
        interactor?.didRetrieve(cars: Array(results), for: camera)
    }
    
    
}
