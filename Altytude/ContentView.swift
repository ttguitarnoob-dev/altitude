//
//  ContentView.swift
//  Altytude
//
//  Created by Travis Thompson on 7/23/25.
//

import SwiftUI
import CoreLocation
import ActivityKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                AltitudeDisplayView(locationManager: locationManager)
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .background {
                startLiveActivity()
            }
        }
    }

    private func startLiveActivity() {
        let attributes = Live_Altitude_DisplayAttributes(name: "World")
        let contentState = Live_Altitude_DisplayAttributes.ContentState(emoji: "😀")
        let content = ActivityContent(state: contentState, staleDate: Date())
        do {
            _ = try Activity<Live_Altitude_DisplayAttributes>.request(
                attributes: attributes,
                content: content,
                pushType: nil
            )
        } catch {
            print("Error starting Live Activity: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
