//
//  CBNavigationController.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/5/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit

class CBNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage.color(Colors.barBackground), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setShadow(7, alpha: 0.04)
        self.navigationBar.isTranslucent = false
        
    }
}

