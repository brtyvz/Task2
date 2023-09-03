//
//  task2_appApp.swift
//  task2_app
//
//  Created by Berat Yavuz on 30.08.2023.
//

import SwiftUI

@main
struct Task2App: App {
    
    @StateObject var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
    }
}






