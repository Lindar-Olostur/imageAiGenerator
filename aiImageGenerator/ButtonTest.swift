//
//  ButtonTest.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 07.09.2024.
//

import SwiftUI

struct ButtonTest: View {
    @State private var items = [
            Item(name: "Profile 1", description: "Description 1"),
            Item(name: "Profile 2", description: "Description 2"),
            Item(name: "Profile 3", description: "Description 3")
        ]
        @State private var choosed = [Bool](repeating: false, count: 3)
        
        var body: some View {
            NavigationView {
                List {
                    ForEach(items.indices, id: \.self) { index in
                        Cell(item: items[index], choosed: $choosed[index])
                            .onLongPressGesture(minimumDuration: 0.01, maximumDistance: 0.01, perform: {
                                choosed[index].toggle()
                            }, onPressingChanged: { pressing in
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    if pressing {
                                        // Эффект при нажатии
                                        impact(style: .medium)
                                    }
                                }
                            })
                    }
                }
                .listStyle(SidebarListStyle())
                .navigationTitle("Profiles")
            }
        }
        
        func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        }
    }

#Preview {
    ButtonTest()
}

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

struct Cell: View {
    let item: Item
    @Binding var choosed: Bool
    @State private var isPressed = false
    
    var body: some View {
        HStack {
            Image(systemName: choosed ? "circle.fill" : "circle")
                .foregroundColor(.primary)
            VStack(alignment: .leading) {
                Text(item.name)
                    .foregroundColor(.primary)
                Text(item.description)
                    .foregroundColor(.secondary)
                    .font(.system(size: 12))
            }
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(isPressed ? 0.2 : 0))
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .contentShape(Rectangle())
    }
}
