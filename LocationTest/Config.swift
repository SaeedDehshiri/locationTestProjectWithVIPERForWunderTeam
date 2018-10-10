//
//  Config.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/5/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import Foundation

enum CBLanguage: String {
    case en_US = "en_US"
}

class CBConfig {
    private var _language: CBLanguage? = nil
    var language: CBLanguage {
        get {
            if _language == nil {
                let str: String?
                    = UserDefaults.standard.string(forKey: "CL.Config.Language")
                if str == nil {
                    _language = CBLanguage.en_US
                } else {
                    _language = CBLanguage(rawValue: str!)
                }
            }
            return _language!
        } set {
            _language = newValue
            UserDefaults.standard.set(_language!.rawValue,
                                      forKey: "CL.Config.Language")
        }
    }
}
