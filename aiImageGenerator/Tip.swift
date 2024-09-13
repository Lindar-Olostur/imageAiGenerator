//
//  Tip.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 09.09.2024.
//

import Foundation
import TipKit

struct InlineTip: Tip {
    // Parameters-Rules
    @Parameter
    static var alreadyDiscovered: Bool = false
    
    var title: Text {
        Text("Tap to save")
            .foregroundStyle(.white)
    }
    var message: Text? {
        Text("The image will be saved in your collection")
            .foregroundStyle(Color(.lSecondary))
    }
    var image: Image? {
        Image(systemName: "hand.tap")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.$alreadyDiscovered) { $0 == false }
        ]
    }
}

struct InlineTip2: Tip {
    /// Parameters-Rules
    @Parameter
    static var alreadyDiscovered: Bool = false
    
    var title: Text {
        Text("Write what you want")
            .foregroundStyle(.white)
    }
    var message: Text? {
        Text("And our AI will create a unique image for you")
            .foregroundStyle(Color(.lSecondary))
    }
    var image: Image? {
        Image(systemName: "sparkles")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.$alreadyDiscovered) { $0 == false }
        ]
    }
}
