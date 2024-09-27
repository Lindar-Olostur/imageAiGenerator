import SwiftUI

struct InfosFieldView: View {
    @State private var isCollapsed = true
    let picture: Picture
    
    var body: some View {
        VStack(alignment: .leading) {
            // Верхняя строка с текстом и кнопкой
            HStack {
                Text("Infos")
                    .font(.system(size: 17))
                    .bold()
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

            if !isCollapsed {
                VStack(alignment: .leading) {
                    Text("Negative Prompt")
                        .font(.system(size: 13))
                        .foregroundColor(.lTertiary)
                        .padding(.top, 4)
                    Text(picture.negativePrompt)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.lQuoternary)
                        .padding(.horizontal, 15)
                        .padding(.vertical)
                        .background(Color.bgTertiary)
                        .cornerRadius(10, corners: .allCorners)
                    Text("Details")
                        .font(.system(size: 13))
                        .foregroundColor(.lTertiary)
                        .padding(.top, 4)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            VStack(alignment: .leading) {
                                Text("Image size")
                                    .font(.system(size: 12))
                                    .foregroundColor(.lTertiary)
                                Text(picture.size)
                                    .font(.system(size: 20))
                                    .foregroundColor(.lSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 15)
                            .padding(.vertical)
                            .background(Color.bgTertiary)
                            .cornerRadius(10, corners: .allCorners)
                            
                            VStack(alignment: .leading) {
                                Text("Resolution")
                                    .font(.system(size: 12))
                                    .foregroundColor(.lTertiary)
                                Text(picture.isUpscaled ? "Upscaled" : "Low")
                                    .font(.system(size: 20))
                                    .foregroundColor(.lSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 15)
                            .padding(.vertical)
                            .background(Color.bgTertiary)
                            .cornerRadius(10, corners: .allCorners)
                            
                            VStack(alignment: .leading) {
                                Text("Model")
                                    .font(.system(size: 12))
                                    .foregroundColor(.lTertiary)
                                Text(picture.model)
                                    .font(.system(size: 20))
                                    .foregroundColor(.lSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 15)
                            .padding(.vertical)
                            .background(Color.bgTertiary)
                            .cornerRadius(10, corners: .allCorners)
                            
                            VStack(alignment: .leading) {
                                Text("Aspect ration")
                                    .font(.system(size: 12))
                                    .foregroundColor(.lTertiary)
                                Text(picture.ratio)
                                    .font(.system(size: 20))
                                    .foregroundColor(.lSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 15)
                            .padding(.vertical)
                            .background(Color.bgTertiary)
                            .cornerRadius(10, corners: .allCorners)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.clear)
        .foregroundColor(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.24), lineWidth: 1)
        )
    }
}

#Preview {
    InfosFieldView(picture: Picture(url: URL(string: "https://via.placeholder.com/300")!, prompt: "", negativePrompt: "Negative Negative", size: "480 x 480", isUpscaled: false, model: "Art", ratio: "1:1 - landscape"))
}
