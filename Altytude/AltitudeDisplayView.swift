//
//  AltitudeDisplayView.swift
//  Altytude
//
//  Created by Travis Thompson on 7/23/25.
//

import SwiftUI
import CoreLocation
import Combine

struct AltitudeDisplayView: View {
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        let altitudeFeetString = locationManager.altitude.map { String(format: "%.2f", $0 * 3.28084) } ?? "--"
        Text("Current Altitude: \(altitudeFeetString) feet")
    }
}

#Preview {
    ContentView()
}
