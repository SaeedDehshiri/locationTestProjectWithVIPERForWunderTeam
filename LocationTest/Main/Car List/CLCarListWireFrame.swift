//
//  CLCarListWireFrame.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/1/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit

class CLCarListWireFrame: CLCarListWireFrameProtocol {
    
    class func createModule() -> UIViewController {
        
        let view: CLCarListViewController = CLCarListViewController()
        
        let presenter: CLCarListPresenterProtocol & CLCarListInteractorOutputProtocol
            = CLCarListPresenter()
        let interactor: CLCarListInteractorInputProtocol & CLCarListDataManagerOutputProtocol
            = CLCarListInteractor()
        let datamanager: CLCarListDataManagerInputProtocol
            = CLCarListDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.datamanager = datamanager
        interactor.presenter = presenter
        datamanager.interactor = interactor
        
        let nav: CBNavigationController
            = CBNavigationController(rootViewController: view)
        
        nav.tabBarItem.image = UIImage(named: "icon-tab-cars")
        nav.tabBarItem.selectedImage = UIImage(named: "icon-tab-cars-selected")
        nav.tabBarItem.title = String.localized("CL.Tab.CarList")
        
        return nav
    }
    
}
