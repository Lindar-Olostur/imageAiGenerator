////
////  CustomTabBar.swift
////  aiImageGenerator
////
////  Created by Lindar Olostur on 08.09.2024.
////
//
//import SwiftUI
//
//struct CustomTabBar: View {
//    @Binding var selectedTab: Int
//    let items: [(image: String, title: String)]
//    
//    var body: some View {
//        ZStack {
//            BlurView(style: .systemThickMaterialDark)
//                .edgesIgnoringSafeArea(.bottom)
//            
//            HStack {
//                ForEach(0..<items.count, id: \.self) { index in
//                    Spacer()
//                    Button {
//                        selectedTab = index
//                    } label: {
//                        VStack(spacing: 6) {
//                            Image(systemName: items[index].image)
//                                .font(.system(size: 20))
//                                .foregroundColor(index == selectedTab ? Color(.cPrimaryLight) : .gray)
//                            Text(items[index].title)
//                                .font(.system(size: 13))
//                                .foregroundColor(index == selectedTab ? Color(.cPrimaryLight) : .gray)
//                        }
//                        .offset(y: 6)
//                    }
//
////                    tabBarItem(image: items[index].image, title: items[index].title, isSelected: selectedTab == index)
////                        .onTapGesture {
////                            selectedTab = index
////                        }
//                    Spacer()
//                }
//            }
//        }
//        .frame(height: 50)
//    }
//    
////    private func tabBarItem(image: String, title: String, isSelected: Bool) -> some View {
////        VStack(spacing: 4) {
////            Image(systemName: image)
////                .font(.system(size: 26))
////                .foregroundColor(isSelected ? Color(.cPrimaryLight) : .gray)
////            Text(title)
////                .font(.system(size: 13))
////                .foregroundColor(isSelected ? Color(.cPrimaryLight) : .gray)
////        }
////        .offset(y: 8)
////    }
//}
