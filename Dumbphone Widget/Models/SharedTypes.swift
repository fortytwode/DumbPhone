//
//  SharedTypes.swift
//  Dumb Phone
//
//  Created by Shamanth Rao on 12/31/24.
//

import Foundation

// Create a namespace to avoid conflicts
public enum SharedTypes {
    public struct AppShortcut: Identifiable, Codable {
        public let id: UUID
        public let name: String
        public let urlScheme: String
        public let iconName: String
        
        public init(id: UUID = UUID(), name: String, urlScheme: String, iconName: String) {
            self.id = id
            self.name = name
            self.urlScheme = urlScheme
            self.iconName = iconName
        }
    }
}

// Convenience extension for default shortcuts
public extension SharedTypes.AppShortcut {
    static let defaultShortcuts = [
        SharedTypes.AppShortcut(name: "Phone", urlScheme: "tel://", iconName: "phone.fill"),
        SharedTypes.AppShortcut(name: "Messages", urlScheme: "sms://", iconName: "message.fill"),
        SharedTypes.AppShortcut(name: "Camera", urlScheme: "photos-redirect://", iconName: "camera.fill")
    ]
}

