//
//  aiImageGeneratorApp.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 06.09.2024.
//

import SwiftUI
import ApphudSDK

@main
struct aiImageGeneratorApp: App {
    @StateObject var userSettings = UserSettings()
    @StateObject var imageLoader = ImageLoader()
    @StateObject var aiGeneratorService = AiService()
    
    @MainActor
    init() {
        Apphud.start(apiKey: "app_9fhEm3CyQtu1i1YQGethzpdzNcpxB3")
    }
    
    var body: some Scene {
        
        WindowGroup {
            VStack {
                if userSettings.isPreloaderVisible /*|| webManager.isLoading*/ {
                    PreloaderView()
                } else {
                    TabsView()
                }
            }
            .environmentObject(aiGeneratorService)
            .environmentObject(userSettings)
            .environmentObject(imageLoader)
            .preferredColorScheme(.dark)
        }
    }
}
