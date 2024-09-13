//
//  TextEditorView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 09.09.2024.
//

import SwiftUI

struct TextEditorView: View {
    @FocusState private var isFocused: Bool
    @Binding var text: String
    let placeholder: String
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .topLeading) {
                
                
                TextEditor(text: Binding(projectedValue: $text))
                    .focused($isFocused)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(text.isEmpty ? .gray.opacity(0.24) : Color.cPrimaryLight.opacity(0.5), lineWidth: 1)
                    )
                    .scrollContentBackground(.hidden)
                    .background(.ultraThinMaterial)
                    .frame(minHeight: 144, alignment: .leading)
                    .cornerRadius(8.0)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .overlay(
                        Button(action: {
                            text = ""
                        }) {
                            Image(systemName: "delete.backward")
                                .foregroundColor(.lSecondary)
                                .padding()
                        }
                            .padding(10),
                        alignment: .bottomTrailing
                    )
                
                Text(isFocused && text.isEmpty ? text : placeholder)
                    .foregroundStyle(.lQuoternary)
                    .padding()
                    .offset(x: 7, y: 10)
                    .opacity(text == "" ? 1 : 0.0)
            }
        }
    }
}

#Preview {
    TextEditorView(text: .constant(""), placeholder: "What do you want to generate?")
}
