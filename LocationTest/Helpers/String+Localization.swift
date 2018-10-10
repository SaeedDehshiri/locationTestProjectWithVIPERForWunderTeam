//
//  String+Localization.swift
//  Ketabchi
//
//  Created by Morteza Ezzabady on 12/24/17.
//  Copyright © 2017 Morteza Ezzabady. All rights reserved.
//

import Foundation


extension String {
    static func localized(_ phrase: String) -> String {
        return NSLocalizedString(phrase, tableName: Config.language.rawValue,
                                 bundle: Bundle.main, value: phrase, comment: "")
    }
}
