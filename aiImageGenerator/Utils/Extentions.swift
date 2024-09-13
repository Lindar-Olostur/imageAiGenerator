//
//  Extentions.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 06.09.2024.
//

import Foundation
import SwiftUI


//--------------------- BUTTONS

struct DisabledButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            //.cornerRadius(10)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(Color(.lQuintuple))
            .background(Color.cSecondaryLight)
            .padding(.horizontal)
            .padding(.bottom)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.2), lineWidth: 1)
                    .shadow(color: Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.2), radius: 2, x: -1, y: -1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}
struct BigButton: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    var opacity: Double = 0.24
    let color1 = Color(.cPrimary)
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color(.white))
            .frame(maxWidth: width, minHeight: height)
            .padding(10)
            .primaryGradient()
            .cornerRadius(10)
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: opacity), radius: 8, x: 0, y: 2)
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: opacity), radius: 8, x: 0, y: 2)
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: opacity), radius: 4, x: 0, y: 1)
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: opacity), radius: 2, x: 0, y: 1)
        
            // Внутренние тени (inset-like)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
                    .shadow(color: Color.white.opacity(0.7), radius: 1, x: 1, y: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.2), lineWidth: 1)
                    .shadow(color: Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.2), radius: 2, x: -1, y: -1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
//--------------------- CORNERS
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//--------------------- TEXT STYLES
struct HeaderStyle: ViewModifier {
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(Color(.white))
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

struct SubHeaderStyle: ViewModifier {
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
            .foregroundColor(Color(.lSecondary))
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

struct CustomText: ViewModifier {
    var alignment: Alignment
    var size: CGFloat
    var color: Color
    var weight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(color)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

extension Text {
    func headerStyle(alignment: Alignment = .leading) -> some View {
        self.modifier(HeaderStyle(alignment: alignment))
    }
    func subHeaderStyle(alignment: Alignment = .leading) -> some View {
        self.modifier(SubHeaderStyle(alignment: alignment))
    }
    func customText(alignment: Alignment = .leading, size: CGFloat = 20, color: Color = .white, weight: Font.Weight = .medium) -> some View {
        self.modifier(CustomText(alignment: alignment, size: size, color: color, weight: weight))
    }
}


//-------------EFFECTS

struct PrimaryGradient: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.cPrimary), Color(.cPrimaryLight)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

struct SecondaryGradient: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.cSecondary), Color(.cSecondaryLight)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

struct GradientShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0),  // Прозрачный цвет (rgba(19, 21, 28, 0))
                                Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 1)   // Непрозрачный цвет #13151C
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
            )
    }
}

struct PrimaryButtonEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
            // Внешние тени
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: 0.24), radius: 16, x: 0, y: 4)
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: 0.24), radius: 16, x: 0, y: 3)
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: 0.24), radius: 8, x: 0, y: 2)
            .shadow(color: Color(red: 188/255, green: 69/255, blue: 23/255, opacity: 0.24), radius: 4, x: 0, y: 1)
        
            // Внутренние тени (inset-like)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
                    .shadow(color: Color.white.opacity(0.4), radius: 2, x: 1, y: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.16), lineWidth: 1)
                    .shadow(color: Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.16), radius: 2, x: -1, y: -1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}

struct SecondaryButtonEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
        // Внешние тени
            .shadow(color: Color(red: 55/255, green: 62/255, blue: 82/255, opacity: 0.24), radius: 24, x: 0, y: 4)
            .shadow(color: Color(red: 55/255, green: 62/255, blue: 82/255, opacity: 0.24), radius: 16, x: 0, y: 3)
            .shadow(color: Color(red: 55/255, green: 62/255, blue: 82/255, opacity: 0.24), radius: 8, x: 0, y: 2)
            .shadow(color: Color(red: 55/255, green: 62/255, blue: 82/255, opacity: 0.24), radius: 4, x: 0, y: 1)
        
        // Внутренние тени (inset)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
                    .shadow(color: Color.white.opacity(0.18), radius: 2, x: 1, y: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.12), lineWidth: 1)
                    .shadow(color: Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.12), radius: 2, x: -1, y: -1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}

struct BlurView: UIViewRepresentable {
    
    // Declare a property 'style' of type UIBlurEffect.Style to store the blur effect style.
    let style: UIBlurEffect.Style
    
    // Initializer for the BlurView, taking a UIBlurEffect.Style as a parameter and setting it to the 'style' property.
    init(style: UIBlurEffect.Style) {
        self.style = style
    }
    
    // Required method of UIViewRepresentable protocol. It creates and returns the UIVisualEffectView.
    func makeUIView(context: Context) -> UIVisualEffectView {
        // Create a UIBlurEffect with the specified 'style'.
        let blurEffect = UIBlurEffect(style: style)
        // Initialize a UIVisualEffectView with the blurEffect.
        let blurView = UIVisualEffectView(effect: blurEffect)
        // Return the configured blurView.
        return blurView
    }
    
    // Required method of UIViewRepresentable protocol. Here, it's empty as we don't need to update the view after creation.
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

extension View {
    func primaryGradient() -> some View {
        self.modifier(PrimaryGradient())
    }
    func secondaryGradient() -> some View {
        self.modifier(SecondaryGradient())
    }
    func gradientShadow() -> some View {
        self.modifier(GradientShadow())
    }
    func primaryButtonEffect() -> some View {
        self.modifier(PrimaryButtonEffect())
    }
    func secondaryButtonEffect() -> some View {
        self.modifier(SecondaryButtonEffect())
    }
}

