//
//  OpenMyUrlIntent.swift
//  Dumb Phone
//
//  Created by Nishchal Visavadiya on 01/01/25.
//

import AppIntents
import SwiftUICore
import UserNotifications

@available(iOS 18.0, *)
struct OpenMyUrlIntent: AppIntent {
    
    static var title: LocalizedStringResource = "OpenMyUrlIntent"
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Value")
    var value: String
    
    init(value: String) {
        self.value = value
    }
    
    init() {
        self.value = ""
    }
    
    func perform() async throws -> some IntentResult & OpensIntent  {
        guard let url = URL(string: value) else {
            fatalError("Invalid URL \(value)")
        }
        let openURLIntent = OpenURLIntent(url)
        return .result(opensIntent: openURLIntent)
    }
}

struct OpenMyUrlIntentLowerIOS: AppIntent {
    
    static var title: LocalizedStringResource = "OpenMyUrlIntentLowerIOS"
    static var openAppWhenRun: Bool = true
    
    @Parameter(title: "Value")
    var value: String
    
    init(value: String) {
        self.value = value
    }
    
    init() {
        self.value = ""
    }
    
    func perform() async throws -> some IntentResult & OpensIntent  {
        guard let url = URL(string: value) else {
            fatalError("Invalid URL \(value)")
        }
        await EnvironmentValues().openURL(url)
        return .result()
    }
}
