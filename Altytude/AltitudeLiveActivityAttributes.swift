// AltitudeLiveActivityAttributes.swift
// Defines ActivityKit attributes and state for altitude Live Activity

import ActivityKit

struct AltitudeLiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var altitudeFeet: Double
    }

    // You could add static properties here (like profile info)
    // For now, we don't need any static data
}
