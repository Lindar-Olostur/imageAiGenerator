import SwiftUI

struct ProgressGenerationView: View {
    @EnvironmentObject var aiGeneratorService: AiService
    @EnvironmentObject var viewModel: ViewModel
    @State private var openGallery = false
    @State var progress = 0.0
    
    var body: some View {
        VStack {
            if openGallery {
                GenerationGalleryView(openGallery: $openGallery)
                    .transition(.move(edge: .trailing))
            } else {
                ZStack(alignment: .topTrailing) {
                    BlurView(style: .dark)
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        viewModel.testProgress = false
                                    } label: {
                                        ZStack {
                                            BlurView(style: .dark)
                                            Image(systemName: "xmark")
                                                .tint(.lSecondary)
                                        }
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(6, corners: .allCorners)
                                    }
                                    .padding()
                                }
                                Spacer()
                                VStack(spacing: 10) {
                                    ProgressCircle(progress: $progress)
                                    
                                    Text("Generating your image")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.top, 8)
                                    Text("Hold it open and wait for the image to be created. It may take up to a minute to generate.")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.lSecondary)
                                        .padding(.horizontal, 28)
                                        .multilineTextAlignment(.center)
                                }
                                Spacer()
                                VStack {
                                    Text("You want to go faster?")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.white)
                                    Button {
                                        viewModel.testProgress = false
                                        viewModel.openPaywall.toggle()
                                    } label: {
                                        HStack {
                                            Image(systemName: "crown.fill")
                                                .font(.system(size: 15))
                                            Text("Upgrade to Pro")
                                                .font(.system(size: 18))
                                                .bold()
                                        }
                                    }
                                    .buttonStyle(MainButton(width: 166, height: 20))
                                    .scaleEffect(0.8)
                                }
                                .padding(.bottom)
                                .opacity(SubscriptionService.shared.hasSubs ? 0 : 1)
                                
                            }
                        )
                }
            }
        }
        .onReceive(aiGeneratorService.$progress) { value in
            withAnimation {
                progress = value
            }
            if value == 1.0 {
                viewModel.recentImages += aiGeneratorService.genImages 
                withAnimation {
                    openGallery.toggle()
                }
            }
        }
        .onAppear {
            progress = 0.0
            aiGeneratorService.startProgressSimulation()
        }
    }
}

#Preview {
    ProgressGenerationView()
        .environmentObject(AiService())
        .environmentObject(ViewModel())
}
struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
