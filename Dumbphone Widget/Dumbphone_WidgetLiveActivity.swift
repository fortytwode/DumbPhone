//
//  Dumbphone_WidgetLiveActivity.swift
//  Dumbphone Widget
//
//  Created by Shamanth Rao on 12/31/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Dumbphone_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Dumbphone_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Dumbphone_WidgetAttributes.self) { context in
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

extension Dumbphone_WidgetAttributes {
    fileprivate static var preview: Dumbphone_WidgetAttributes {
        Dumbphone_WidgetAttributes(name: "World")
    }
}

extension Dumbphone_WidgetAttributes.ContentState {
    fileprivate static var smiley: Dumbphone_WidgetAttributes.ContentState {
        Dumbphone_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Dumbphone_WidgetAttributes.ContentState {
         Dumbphone_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Dumbphone_WidgetAttributes.preview) {
   Dumbphone_WidgetLiveActivity()
} contentStates: {
    Dumbphone_WidgetAttributes.ContentState.smiley
    Dumbphone_WidgetAttributes.ContentState.starEyes
}
