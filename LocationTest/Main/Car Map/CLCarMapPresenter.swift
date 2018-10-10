//
//  CLCarMapPresenter.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/6/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import Foundation
import GoogleMaps

class CLCarMapPresenter {
    weak var view: CLCarMapViewControllerProtocol?
    var interactor: CLCarMapInteractorInputProtocol?
    
}

extension CLCarMapPresenter: CLCarMapPresenterProtocol {
    
    func viewDidLoad() {
    }
    func stoppedAt(camera: GMSCameraPosition, projection: GMSProjection) {
        interactor?.retrieveCarsFor(camera: camera, projection: projection)
    }
    func showCarDetails(forCar car: CMCar) {
        // :)
    }
}

extension CLCarMapPresenter: CLCarMapInteractorOutputProtocol {
    
    func onError() {
        
    }
    
    func didRetrieve(cars: [CMCar], for camera: GMSCameraPosition) {
        view?.didRetrieve(cars: cars, for: camera)
    }
    
}
