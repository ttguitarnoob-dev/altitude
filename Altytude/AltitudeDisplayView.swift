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
        let altitudeFeetString = locationManager.altitude.map { String(Int(round($0 * 3.28084))) } ?? "--"
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.clear)
                .frame(width: 300, height: 300)
                .glassEffect(.regular.interactive())
                .shadow(radius: 8)
            VStack {
                Text("Current Altitude:")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                Text("\(altitudeFeetString) ft")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
