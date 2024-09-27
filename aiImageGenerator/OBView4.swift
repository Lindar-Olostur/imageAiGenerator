import SwiftUI
import StoreKit

struct OBView4: View {
    @State private var nextViewShow = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgPrimary.ignoresSafeArea()
                    .onAppear {
                        requestReview()
                    }
                VStack {
                    Image("OB4")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                VStack(alignment: .center) {
                    Spacer()
                    Text("Share Your Feedback!")
                        .bigTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 20)
                    
                    Text("Your feedback helps us improve. Please take a moment to rate our app!")
                        .grayTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    NavigationLink(destination: OBView5()) {
                        Text("Continue")
                            .font(.system(size: 17))
                    }
                    .buttonStyle(MainButton(width: .infinity, height: 38))
                    .padding()
                    PageControlView(numberOfPages: 4, currentPage: 3, activeColor: .white, inactiveColor: .white.opacity(0.3))
                }
            }
            .navigationDestination(isPresented: $nextViewShow) {
                OBView5()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    OBView4()
}
