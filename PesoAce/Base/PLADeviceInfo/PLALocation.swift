//
//  PLALocation.swift
//  PesoAce
//
//  Created by apple on 2024/8/12.
//

import UIKit
import CoreLocation
import RxSwift

class LocationPModel: NSObject {
    var scratched : String = ""
    var align : String = ""
    var ome: Double = 0.0
    var grasping: Double = 0.0
    var noticing : String = ""
    var slamming : String = ""
    var punched : String = ""
}

typealias LocationModelBlock = (_ locationModel: LocationPModel) -> Void

class PLALocation: NSObject {
    
    static let shared = PLALocation()
    private var locationManager = CLLocationManager()
    
    private var locationUpdateHandler: LocationModelBlock?
    
    var locatinModel = LocationPModel()
    
    var obs: PublishSubject<LocationPModel?> = PublishSubject()
    
    let bag = DisposeBag()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        obs.debounce(RxTimeInterval.milliseconds(2000), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] locationModel in
                guard let self = self, let locationModel = locationModel else { return }
                self.locationUpdateHandler?(locationModel)
            }).disposed(by: bag)
    }
    
}

extension PLALocation: CLLocationManagerDelegate {
    
    func startUpdatingLocation(completion: @escaping LocationModelBlock) {
        locationUpdateHandler = completion
        if (CLLocationManager.authorizationStatus() == .denied) {
            locationUpdateHandler?(locatinModel)
        }else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
            locationUpdateHandler?(locatinModel)
            locationManager.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        getAddressFromCoordinates(latitude: latitude, longitude: longitude)
    }
    
    private func getAddressFromCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let model = LocationPModel()
        model.ome = longitude
        model.grasping = latitude
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self, let placemark = placemarks?.first else { return }
            model.align = placemark.country ?? ""
            model.punched = placemark.isoCountryCode ?? ""
            model.scratched = placemark.administrativeArea ?? ""
            model.slamming = placemark.locality ?? ""
            model.noticing = (placemark.subLocality ?? "") + (placemark.thoroughfare ?? "")
            DispatchQueue.global().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.locatinModel = model
            }
            self.obs.onNext(model)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let observable = Observable.of("Hello", "World")
        observable.subscribe { str in
            
        }.disposed(by: bag)
    }
    
}
