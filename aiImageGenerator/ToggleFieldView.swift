//
//  ToggleFieldView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 09.09.2024.
//

import SwiftUI

struct ToggleFieldView: View {
    @State private var isCollapsed = true
    @Binding var textFieldInput: String
    
    
    var body: some View {
        VStack {
            // Верхняя строка с текстом и кнопкой
            HStack {
                Text("Negative Words")
                    .font(.headline)
                    .bold()
                Text("Optional")
                    .font(.system(size: 12))
                    .foregroundColor(.lTertiary)
                Spacer()
                Button(action: {
                    withAnimation {
                        isCollapsed.toggle() // Показ/скрытие поля
                    }
                }) {
                    HStack {
                        Text(isCollapsed ? "Open" : "Collapse")
                            .font(.system(size: 15))
                        Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                            .foregroundColor(.orange)
                    }
                }
            }
            
            // Поле ввода, которое показывается при открытии
            if !isCollapsed {
                TextEditorView(text: $textFieldInput, placeholder: "Use negative words like “blue” to get less blue color").padding(-16)
            }
        }
        .padding()
        .background(Color.clear)
        .foregroundColor(.white)
    }
}

#Preview {
    ToggleFieldView(textFieldInput: .constant(""))
}
