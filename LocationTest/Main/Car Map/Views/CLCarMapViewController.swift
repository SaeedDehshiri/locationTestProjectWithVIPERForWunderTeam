//
//  ViewController.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 9/30/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit
import GoogleMaps

class CLCarMapViewController: UIViewController {

    var presenter: CLCarMapPresenterProtocol?
    
    var infoWindow: CLCarMapInfoView = CLCarMapInfoView()
    var mapView: GMSMapView!
    var locationMarker: GMSMarker? = nil
    var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        
        let camera = GMSCameraPosition.camera(withLatitude: 31.8918948, longitude: 54.3596615, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        self.view.addSubview(mapView)
        
        self.title = String.localized("CL.Tab.CarMap.Title")
        
        infoWindow.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        presenter?.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapView.frame = self.view.bounds
        
        presenter?.stoppedAt(camera: mapView.camera, projection: mapView.projection)
        
    }

}

extension CLCarMapViewController: CLCarMapViewControllerProtocol {
    
    func didRetrieve(cars: [CMCar], for camera: GMSCameraPosition) {
        let currentCamera = mapView.camera
        if camera.target.latitude == currentCamera.target.latitude
            && camera.target.longitude == currentCamera.target.longitude
            && camera.zoom == currentCamera.zoom
            && camera.viewingAngle == currentCamera.viewingAngle {
            
            print("CNT \(markers.count)")
            
            // check for not-present markers
            for marker in markers {
                let id: Int = (marker.userData as! CMCar).id
                if !cars.contains(where: { $0.id == id }) {
                    marker.map = nil
                }
            }
            
            // remove markers
            markers = markers.filter({ $0.map != nil })
            
            // add new markers
            for car in cars {
                if !markers.contains(where: { ($0.userData as! CMCar).id == car.id }) {
                    let marker: GMSMarker = GMSMarker(position:
                        .init(latitude: car.lat, longitude: car.long))
                    if mapView.settings.scrollGestures {
                        marker.map = mapView
                    }
                    marker.userData = car
                    marker.iconView = UIImageView(image:
                        UIImage(named: "icon-pin-car-\(car.exterior == "GOOD" ? "good" : "bad")"))
                    marker.iconView?.frame.size = CGSize(width: 25, height: 25)
                    markers.append(marker)
                }
            }
            
        }
    }
    
}

extension CLCarMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if infoWindow.superview?.superview != nil {
            UIView.animate(withDuration: 0.15, animations: { [unowned self] () in
                for m in self.markers {
                    m.iconView?.alpha = 1
                }
                self.infoWindow.transform = .init(scaleX: 0, y: 0)
            }) { [unowned self] (true) in
                self.infoWindow.removeFromSuperview()
                self.infoWindow.transform = .identity
                mapView.settings.setAllGesturesEnabled(true)
            }
        }
        mapView.settings.setAllGesturesEnabled(false)
        let car: CMCar = marker.userData as! CMCar
        locationMarker = marker
        guard let location = locationMarker?.position else {
            return false
        }
        let point: CGPoint = mapView.projection.point(for: location)
        infoWindow.transform = .identity
        infoWindow.load(car: car)
        infoWindow.adjustSize()
        infoWindow.center.x = point.x
        infoWindow.frame.origin.y = point.y - infoWindow.frame.size.height - 25
        infoWindow.transform = .init(scaleX: 0, y: 0)
        self.view.addSubview(infoWindow)
        UIView.animate(withDuration: 0.15) { [unowned self] () in
            for m in self.markers {
                if (marker.userData as! CMCar).id != (m.userData as! CMCar).id {
                    m.iconView?.alpha = 0
                }
            }
            self.infoWindow.transform = .identity
        }
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (locationMarker != nil){
            guard let location = locationMarker?.position else {
                return
            }
            let point: CGPoint = mapView.projection.point(for: location)
            infoWindow.center.x = point.x
            infoWindow.frame.origin.y = point.y - infoWindow.frame.size.height - 25
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.15, animations: { [unowned self] () in
            for m in self.markers {
                m.iconView?.alpha = 1
            }
            self.infoWindow.transform = .init(scaleX: 0, y: 0)
        }) { [unowned self] (true) in
            self.infoWindow.removeFromSuperview()
            self.infoWindow.transform = .identity
            mapView.settings.setAllGesturesEnabled(true)
        }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        presenter?.stoppedAt(camera: position, projection: mapView.projection)
    }
    
}
