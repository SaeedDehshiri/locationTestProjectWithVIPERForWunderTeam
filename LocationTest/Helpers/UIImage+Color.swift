//
//  UIImage+Color.swift
//  AppStore
//
//  Created by Saeed Dehshiri on 9/8/17.
//  Copyright © 2017 Saeed Dehshiri. All rights reserved.
//

import UIKit

extension UIImage {
    class func color(_ color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
