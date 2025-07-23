//
//  Live_Altitude_DisplayBundle.swift
//  Live Altitude Display
//
//  Created by Travis Thompson on 7/23/25.
//

import WidgetKit
import SwiftUI

@main
struct Live_Altitude_DisplayBundle: WidgetBundle {
    var body: some Widget {
        Live_Altitude_Display()
        Live_Altitude_DisplayControl()
        Live_Altitude_DisplayLiveActivity()
    }
}
