//
//  Dumb_PhoneApp.swift
//  Dumb Phone
//
//  Created by Shamanth Rao on 12/31/24.
//

import SwiftUI

@main
struct Dumb_PhoneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
        }
    }
}
