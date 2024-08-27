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

//    static let shared = PLALocation()
    
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
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        obs.debounce(RxTimeInterval.milliseconds(2000), scheduler: MainScheduler.instance)
            .subscribe(onNext: { locationModel in
                if let locationModel = locationModel {
                    self.locationUpdateHandler?(locationModel)
                }
            }).disposed(by: bag)
    }
    
    deinit {
        print("obsobsobsobsobsobs")
    }
    
}

extension PLALocation: CLLocationManagerDelegate {
    
    func startUpdatingLocation(completion: @escaping LocationModelBlock) {
        locationUpdateHandler = completion
        if CLLocationManager.authorizationStatus() == .denied {
            let model = LocationPModel()
            locationUpdateHandler?(model)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
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
        getinates(latitude: latitude, longitude: longitude)
    }

    private func getinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let model = LocationPModel()
        let geocoder = CLGeocoder()
        model.grasping = latitude
        model.ome = longitude
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self, let placemark = placemarks?.first else { return }
            model.slamming = placemark.locality ?? ""
            model.noticing = (placemark.subLocality ?? "") + (placemark.thoroughfare ?? "")
            model.align = placemark.country ?? ""
            model.punched = placemark.isoCountryCode ?? ""
            model.scratched = placemark.administrativeArea ?? ""
            self.locatinModel = model
            self.obs.onNext(model)
            self.obs.onCompleted()
            self.locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to update location: \(error.localizedDescription)")
    }

}
