import Foundation

class WidgetSettings: ObservableObject {
    @Published var selectedShortcuts: [SharedTypes.AppShortcut] {
        didSet {
            saveShortcuts()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "selectedShortcuts"),
           let shortcuts = try? JSONDecoder().decode([SharedTypes.AppShortcut].self, from: data) {
            self.selectedShortcuts = shortcuts
        } else {
            self.selectedShortcuts = SharedTypes.AppShortcut.defaultShortcuts
        }
    }
    
    private func saveShortcuts() {
        if let encoded = try? JSONEncoder().encode(selectedShortcuts) {
            UserDefaults.standard.set(encoded, forKey: "selectedShortcuts")
        }
    }
} 