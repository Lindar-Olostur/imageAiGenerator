////
////  BlurTest.swift
////  aiImageGenerator
////
////  Created by Lindar Olostur on 07.09.2024.
////
//
//import SwiftUI
//
//struct BlurTest: View {
//    @State private var selectedTab = 0
//        
//        let tabItems = [
//            (image: "pencil.line", title: "Create"),
//            (image: "plus.magnifyingglass", title: "Inspiration"),
//            (image: "sparkles.rectangle.stack", title: "Collection")
//        ]
//        
//        var body: some View {
//            ZStack(alignment: .bottom) {
//                TabView(selection: $selectedTab) {
//                   // YellowScreen()
//                        .tag(0)
//                    Text("Search View")
//                        .tag(1)
//                    Text("Profile View")
//                        .tag(2)
//                }
//                
////                CustomTabBar(selectedTab: $selectedTab, items: tabItems)
//            }
//        }
//}
//
//#Preview {
//    BlurTest()
//}
//
//
