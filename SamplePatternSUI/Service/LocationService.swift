//
//  LocationService.swift
//  SamplePatternSUI
//
//  Created by Jazilul Athoya on 06/08/21.
//

import Foundation
import CoreLocation

class LocationService: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var lastUpdateTimestamp = 0
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentPlacemark: CLPlacemark?
    @Published var currentLocation: CLLocation? {
        willSet {
            print("Test service")
        }
    }
    
    override init() {
        super.init()
//        lastUpdateTimestamp = Int(Date().timeIntervalSince1970)
        self.locationManager.delegate = self
    }
    
    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    public func getLocation() {
        if authorisationStatus == .notDetermined {
            requestAuthorisation()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func getLocationNameBy(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self?.currentPlacemark = placemarks?.first
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
        switch authorisationStatus {
        case .authorizedAlways:
            self.getLocation()
        case .authorizedWhenInUse:
            self.getLocation()
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        if let firstLocation = locations.first, currentTimestamp - lastUpdateTimestamp > 1 {
            lastUpdateTimestamp = currentTimestamp
            currentLocation = firstLocation
            self.getLocationNameBy(location: firstLocation)
            locationManager.stopUpdatingLocation()
        }
    }
}
