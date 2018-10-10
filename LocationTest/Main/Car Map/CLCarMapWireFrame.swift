//
//  CLCarMapWireFrame.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/6/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit


class CLCarMapWireFrame: CLCarMapWireFrameProtocol {
    
    class func createModule() -> UIViewController {
        
        let view: CLCarMapViewController = CLCarMapViewController()
        
        let presenter: CLCarMapPresenterProtocol & CLCarMapInteractorOutputProtocol
            = CLCarMapPresenter()
        let interactor: CLCarMapInteractorInputProtocol & CLCarMapDataManagerOutputProtocol
            = CLCarMapInteractor()
        let datamanager: CLCarMapDataManagerInputProtocol
            = CLCarMapDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.datamanager = datamanager
        interactor.presenter = presenter
        datamanager.interactor = interactor
        
        let nav: CBNavigationController
            = CBNavigationController(rootViewController: view)
        
        nav.tabBarItem.image = UIImage(named: "icon-tab-map")
        nav.tabBarItem.selectedImage = UIImage(named: "icon-tab-map-selected")
        nav.tabBarItem.title = String.localized("CL.Tab.CarMap")
        
        return nav
    }
    
}
