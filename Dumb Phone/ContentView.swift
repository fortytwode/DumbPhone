//
//  ContentView.swift
//  Dumb Phone
//
//  Created by Shamanth Rao on 12/31/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var settings = WidgetSettings()
    @State private var isEditingShortcuts = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Widget Preview") {
                    VStack(spacing: 12) {
                        ForEach(settings.selectedShortcuts) { shortcut in
                            Button(action: {
                                if let url = URL(string: shortcut.urlScheme) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: shortcut.iconName)
                                    Text(shortcut.name)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
                .buttonStyle(.plain)
                
                Section("Widget Instructions") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("To add the widget:")
                            .font(.headline)
                        Text("1. Long press on your home screen")
                        Text("2. Tap the + button in top left")
                        Text("3. Search for 'DumbPhone'")
                        Text("4. Add the widget to your screen")
                    }
                    .padding(.vertical)
                }
                
                Section("Settings") {
                    Button("Edit Shortcuts") {
                        isEditingShortcuts = true
                    }
                }
            }
            .navigationTitle("DumbPhone")
            .sheet(isPresented: $isEditingShortcuts) {
                ShortcutEditorView(settings: settings)
            }
        }
    }
}

struct ShortcutEditorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var settings: WidgetSettings
    @State private var shortcuts: [SharedTypes.AppShortcut]
    
    init(settings: WidgetSettings) {
        self.settings = settings
        _shortcuts = State(initialValue: settings.selectedShortcuts)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(shortcuts) { shortcut in
                    HStack {
                        Image(systemName: shortcut.iconName)
                        Text(shortcut.name)
                    }
                }
                .onMove { from, to in
                    shortcuts.move(fromOffsets: from, toOffset: to)
                }
            }
            .navigationTitle("Edit Shortcuts")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    settings.selectedShortcuts = shortcuts
                    dismiss()
                }
            )
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ContentView()
}
