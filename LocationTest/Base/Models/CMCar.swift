//
//  CMCar.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/6/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import Realm
import RealmSwift

@objc class CMCar: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var address: String = ""
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var long: Double = 0.0
    @objc dynamic var engineType: String = ""
    @objc dynamic var exterior: String = ""
    @objc dynamic var fuel: Int = 0
    @objc dynamic var interior: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var vin: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
