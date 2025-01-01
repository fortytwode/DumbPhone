//
//  Dumbphone_Widget.swift
//  Dumbphone Widget
//
//  Created by Shamanth Rao on 12/31/24.
//

import WidgetKit
import SwiftUI
import AppIntents

struct SimpleEntry: TimelineEntry {
    let date: Date
    let shortcuts: [SharedTypes.AppShortcut]
    let configuration: ConfigurationAppIntent
}

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            shortcuts: SharedTypes.AppShortcut.defaultShortcuts,
            configuration: ConfigurationAppIntent()
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            shortcuts: SharedTypes.AppShortcut.defaultShortcuts,
            configuration: ConfigurationAppIntent()
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            shortcuts: SharedTypes.AppShortcut.defaultShortcuts,
            configuration: ConfigurationAppIntent()
        )
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct Dumbphone_WidgetEntryView : View {
    let entry: SimpleEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(entry.shortcuts) { shortcut in
                Button(intent: getIntent(scheme: shortcut.urlScheme)) {
                    HStack {
                        Image(systemName: shortcut.iconName)
                        Text(shortcut.name)
                            .font(.headline)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .buttonStyle(.plain)
            }
            Spacer()
        }
    }
    
    private func getIntent(scheme: String) -> any AppIntent {
        if #available(iOS 18, *) {
            return OpenMyUrlIntent(value: scheme)
        } else {
            return OpenMyUrlIntentLowerIOS(value: scheme)
        }
    }
}

struct Dumbphone_Widget: Widget {
    let kind: String = "Dumbphone_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Dumbphone_WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemLarge])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}
