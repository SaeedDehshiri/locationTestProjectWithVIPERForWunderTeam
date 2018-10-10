//
//  UIView+Shadow.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/5/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit

extension UIView {
    func setShadow(_ radius: CGFloat,
                   alpha: Float = 0.1,
                   color: UIColor = .black,
                   x: CGFloat = 0,
                   y: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = .init(width: x, height: y)
        layer.shadowRadius = radius
        layer.shadowOpacity = alpha
    }
}
