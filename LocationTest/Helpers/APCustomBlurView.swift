//
//  APCustomBlurView.swift
//  kGram
//
//  Created by Morteza Ezzabady on 6/18/17.
//  Copyright © 2017 Morteza Ezzabady. All rights reserved.
//

import UIKit

class APCustomBlurView: UIVisualEffectView {

    private let blurEffect: UIBlurEffect
    public var blurRadius: CGFloat {
        return blurEffect.value(forKeyPath: "blurRadius") as! CGFloat
    }
    
    public convenience init() {
        self.init(withRadius: 3)
    }
    
    public init(withRadius radius: CGFloat) {
        let customBlurClass: AnyObject.Type = NSClassFromString("_UICustomBlurEffect")!
        let customBlurObject: NSObject.Type = customBlurClass as! NSObject.Type
        self.blurEffect = customBlurObject.init() as! UIBlurEffect
        self.blurEffect.setValue(1.0, forKeyPath: "scale")
        self.blurEffect.setValue(radius, forKeyPath: "blurRadius")
        super.init(effect: radius == 0 ? nil : self.blurEffect)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(withRadius: 3)
    }
    
    public func setBlurRadius(radius: CGFloat) {
        guard radius != blurRadius else {
            return
        }
        blurEffect.setValue(radius, forKeyPath: "blurRadius")
        self.effect = blurEffect
    }

}
