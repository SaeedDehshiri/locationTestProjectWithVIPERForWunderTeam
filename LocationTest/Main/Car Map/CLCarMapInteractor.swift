//
//  CLCarMapInteractor.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/6/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import Foundation
import GoogleMaps

class CLCarMapInteractor: CLCarMapInteractorInputProtocol {
    weak var presenter: CLCarMapInteractorOutputProtocol?
    
    var datamanager: CLCarMapDataManagerInputProtocol?
    
    func retrieveCarsFor(camera: GMSCameraPosition, projection: GMSProjection) {
        datamanager?.retrieveCarsFor(camera: camera, projection: projection)
    }
}

extension CLCarMapInteractor: CLCarMapDataManagerOutputProtocol {
    func didRetrieve(cars: [CMCar], for camera: GMSCameraPosition) {
        presenter?.didRetrieve(cars: cars, for: camera)
    }
}
