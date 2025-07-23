//
//  LocationManager.swift
//  Altytude
//
//  Created by Travis Thompson on 7/23/25.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var altitude: CLLocationDistance?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.altitude = locations.last?.altitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Intentionally left empty
    }
}
