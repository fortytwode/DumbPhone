//
//  Dumbphone_WidgetControl.swift
//  Dumbphone Widget
//
//  Created by Shamanth Rao on 12/31/24.
//

import AppIntents
import SwiftUI
import WidgetKit

struct TimerConfiguration: AppIntent, WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Timer Configuration"
    static var description = IntentDescription("Configure timer settings")
    
    @Parameter(title: "Timer Name", default: "Default Timer")
    var timerName: String
}

struct StartTimerIntent: SetValueIntent {
    static var title: LocalizedStringResource = "Start Timer"
    static var description = IntentDescription("Starts or stops the timer")
    
    @Parameter(title: "Timer Name", default: "Default Timer")
    var name: String
    
    init() {
        self.name = "Default Timer"
    }
    
    init(_ name: String) {
        self.name = name
    }
    
    func perform() async throws -> some IntentResult & ReturnsValue<Bool> {
        return .result(value: true)
    }
}

struct Dumbphone_WidgetControl: Widget {
    let kind: String = "com.rocketship.dumbphone.Dumbphone Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ControlProvider()) { entry in
            ControlWidgetView(value: entry)
        }
        .configurationDisplayName("Timer Control")
        .description("Control your timer")
    }
}

struct ControlWidgetView: View {
    let value: Dumbphone_WidgetControl.Value
    
    var body: some View {
        VStack {
            Text(value.name)
            Label(value.isRunning ? "On" : "Off", systemImage: "timer")
        }
    }
}

extension Dumbphone_WidgetControl {
    struct Value {
        var isRunning: Bool
        var name: String
    }

    struct ControlProvider: TimelineProvider {
        typealias Entry = Value
        
        func placeholder(in context: Context) -> Value {
            Value(isRunning: false, name: "Default Timer")
        }
        
        func getSnapshot(in context: Context, completion: @escaping (Value) -> Void) {
            completion(Value(isRunning: false, name: "Default Timer"))
        }
        
        func getTimeline(in context: Context, completion: @escaping (Timeline<Value>) -> Void) {
            let entry = Value(isRunning: false, name: "Default Timer")
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
}
