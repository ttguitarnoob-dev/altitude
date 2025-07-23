//
//  Live_Altitude_DisplayLiveActivity.swift
//  Live Altitude Display
//
//  Created by Travis Thompson on 7/23/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Live_Altitude_DisplayAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Live_Altitude_DisplayLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Live_Altitude_DisplayAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Live_Altitude_DisplayAttributes {
    fileprivate static var preview: Live_Altitude_DisplayAttributes {
        Live_Altitude_DisplayAttributes(name: "World")
    }
}

extension Live_Altitude_DisplayAttributes.ContentState {
    fileprivate static var smiley: Live_Altitude_DisplayAttributes.ContentState {
        Live_Altitude_DisplayAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Live_Altitude_DisplayAttributes.ContentState {
         Live_Altitude_DisplayAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Live_Altitude_DisplayAttributes.preview) {
   Live_Altitude_DisplayLiveActivity()
} contentStates: {
    Live_Altitude_DisplayAttributes.ContentState.smiley
    Live_Altitude_DisplayAttributes.ContentState.starEyes
}
