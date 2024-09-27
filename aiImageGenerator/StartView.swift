import SwiftUI
import AppTrackingTransparency

struct StartView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var rotation: Double = 0.0
    @State private var showNextView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgPrimary.ignoresSafeArea()
                Image("preLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
                VStack {
                    Spacer()
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.7)
                        .padding(.bottom, 60)
                }
            }
            .navigationDestination(isPresented: $showNextView) {
                OBView1()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                requestATT()
            }
        }
    }
    func checkOB() {
        if viewModel.isOBoardingFinished == false {
            showNextView = true
        } else {
            viewModel.isStartScreenVisible = false
        }
    }
    private func requestATT() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Authorized")
                checkOB()
            case .denied:
                print("Denied")
                checkOB()
            case .notDetermined:
                print("Not Determined")
                checkOB()
            case .restricted:
                print("Restricted")
                checkOB()
            @unknown default:
                print("Unknown")
                checkOB()
            }
        }
    }
}

#Preview {
    StartView()
        .environmentObject(ViewModel())
}
