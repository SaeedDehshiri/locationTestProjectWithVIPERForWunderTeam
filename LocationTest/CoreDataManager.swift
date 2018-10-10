//
//  CoreDataManager.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/5/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Alamofire

class CBCoreDataManager {
    
    let realm: Realm = try! Realm()
    let realmQueue: String = "CarList.Realm"
    
    func fetchData(_ completion: @escaping () -> ()) {
        
        Alamofire.request("https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json")
            .response { (response) in
                DispatchQueue.main.async {
                    guard let data: Data = response.data else {
                        completion()
                        return
                    }
                    
                    let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                        // do stuff
                        try! self.realm.write { [unowned self] () in
                            self.realm.deleteAll()
                        }
                        
                        
                        let carsDetails: NSArray = jsonResult["placemarks"] as! NSArray
                                                
                        var id = 0
                        for item in carsDetails{
                            let data: NSDictionary = item as! NSDictionary
                            let address = data.object(forKey: "address") as! String
                            let cordinates = data.object(forKey: "coordinates") as? NSArray
                            let engineType = data.object(forKey: "engineType") as! String
                            let exterior = data.object(forKey: "exterior") as! String
                            let fuel = data.object(forKey: "fuel") as! Int
                            let interior = data.object(forKey: "interior") as! String
                            let name = data.object(forKey: "name") as! String
                            let vin = data.object(forKey: "vin") as! String
                            
                            let carDetailObject = CMCar()
                            carDetailObject.id = id
                            carDetailObject.address = address
                            if cordinates != nil{
                                carDetailObject.lat = Double("\(cordinates![1])")!
                                carDetailObject.long = Double("\(cordinates![0])")!
                            }
                            carDetailObject.engineType = engineType
                            carDetailObject.exterior = exterior
                            carDetailObject.fuel = fuel
                            carDetailObject.interior = interior
                            carDetailObject.name = name
                            carDetailObject.vin = vin
                            
                            let carDetailRealmObject = self.realm.object(ofType: CMCar.self, forPrimaryKey: id)
                            if  carDetailRealmObject == nil {
                                try! self.realm.write { [unowned self] () in
                                    self.realm.add(carDetailObject)
                                }
                            }
                            
                            id += 1
                        }
                        
                    }
                    completion()
                }
                
        }
        
    }
    
}
