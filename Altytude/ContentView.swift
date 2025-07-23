//
//  ContentView.swift
//  Altytude
//
//  Created by Travis Thompson on 7/23/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                AltitudeDisplayView(locationManager: locationManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
