//
//  CLCarDetailsProtocols.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 9/30/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//
import UIKit
import GoogleMaps

protocol CLCarMapViewControllerProtocol: class {
    var presenter: CLCarMapPresenterProtocol? { get set }
    func didRetrieve(cars:[CMCar], for camera: GMSCameraPosition)
}

protocol CLCarMapWireFrameProtocol: class {
    static func createModule() -> UIViewController
}

protocol CLCarMapPresenterProtocol: class {
    var view: CLCarMapViewControllerProtocol? { get set }
    var interactor: CLCarMapInteractorInputProtocol? { get set }
    func viewDidLoad()
    func stoppedAt(camera: GMSCameraPosition, projection: GMSProjection)
    func showCarDetails(forCar car: CMCar)
}

protocol CLCarMapInteractorOutputProtocol: class {
    func didRetrieve(cars:[CMCar], for camera: GMSCameraPosition)
    func onError()
}

protocol CLCarMapInteractorInputProtocol: class {
    var presenter: CLCarMapInteractorOutputProtocol? { get set }
    var datamanager: CLCarMapDataManagerInputProtocol? { get set }
    func retrieveCarsFor(camera: GMSCameraPosition, projection: GMSProjection)
}

protocol CLCarMapDataManagerOutputProtocol: class {
    func didRetrieve(cars:[CMCar], for camera: GMSCameraPosition)
}

protocol CLCarMapDataManagerInputProtocol: class {
    var interactor: CLCarMapDataManagerOutputProtocol? { get set }
    func retrieveCarsFor(camera: GMSCameraPosition, projection: GMSProjection)
}


