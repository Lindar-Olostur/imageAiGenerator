//
//  SettingsRow.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 12.09.2024.
//

import SwiftUI

struct SettingsRow: View {
    var iconName: String
    var title: String
    //let onTap: () -> Void
    
    var body: some View {
        HStack {
            SettingsIcon(iconName: iconName)
                .padding(.trailing, 8)
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 17))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.lQuoternary)
        }
        .cornerRadius(10, corners: .allCorners)

    }
}
struct SettingsIcon: View {
    var iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(.cPrimaryLight)
            .font(.system(size: 24))
    }
}
#Preview {
    SettingsRow(iconName: "heart", title: "Heart")
}
