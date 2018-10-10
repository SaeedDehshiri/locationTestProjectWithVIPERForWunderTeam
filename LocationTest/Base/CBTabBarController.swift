//
//  CBTabBarController.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/5/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit

class CBTabBarController: UITabBarController {
    /*init() {
        super.init(nibName: nil, bundle: nil)
        
        
        
    }
    convenience required init?(coder aDecoder: NSCoder) { self.init() }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [CLCarListWireFrame.createModule(),
                                CLCarMapWireFrame.createModule()]
        self.tabBar.backgroundImage = UIImage.color(Colors.barBackground)
        self.tabBar.isTranslucent = false
        self.tabBar.shadowImage = UIImage()
        self.tabBar.setShadow(7, alpha: 0.04)
        
    }
}
