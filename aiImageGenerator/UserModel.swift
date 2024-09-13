//
//  Model.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import Foundation
import UIKit

struct ImageData: Identifiable {
    let id = UUID()
    let url: URL
}

enum GenStyle: String, CaseIterable {
    case art = "🎨 Art"
    case photo = "📸 Photo"
    case drawing = "✏️ Drawing"
    case none = "⛔️ None"
}

struct Picture: Codable, Equatable, Identifiable {
    var id = UUID()
    let url: URL
    let prompt: String
    let negativePrompt: String
    var size: String
    var isUpscaled: Bool
    let model: String
    let ratio: String
}

