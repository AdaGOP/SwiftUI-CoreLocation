//
//  LocationViewModel.swift
//  SamplePatternSUI
//
//  Created by Jazilul Athoya on 09/08/21.
//

import Foundation
import CoreLocation
import Combine

class LocationViewModel: ObservableObject {
    @Published var currentLocation: CLLocation? {
        willSet {
            print("Test vm")
        }
    }
    
    var locationService: LocationService = LocationService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        locationService.$currentLocation.assign(to: \.currentLocation, on: self).store(in: &cancellables)
//        testLoca = locationService.$currentLocation
//        locationService.subjectCurrentLocation.
//        locationService.$currentLocation.
//        locationService.$currentLocation.sink { [weak self] location in
//            self?.currentLocation = location
//        }.store(in: &cancellables)
    }
    
    func getLocation() {
        objectWillChange.send()
        locationService.getLocation()
    }
}
