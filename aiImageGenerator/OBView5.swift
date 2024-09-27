import SwiftUI
import UserNotifications

struct OBView5: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var nextViewShow = false
    @State private var permissionGranted = false
    
    var body: some View {
        ZStack {
            ZStack {
                Color.bgPrimary
                Image("")
                    .frame(width: 340, height: 150)
                    .background(Color.cPrimaryLight)
                    .blur(radius: 37.5)
                    .opacity(0.65)
            }
            .ignoresSafeArea()
            VStack {
                ZStack {
                    Image("OB5")
                        .resizable()
                        .aspectRatio(3/5, contentMode: .fit)
                        .padding(.horizontal, 40)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.clear, location: 0),
                                    .init(color: Color(.bgPrimary), location: 0.75000005)
                                ]),
                                startPoint: UnitPoint(x: 0.50005, y: 0.60005),
                                endPoint: .bottom
                            )
                        )
                    Image("push5")
                        .resizable()
                        .scaledToFit()
                        .padding(18)
                        .offset(y: -40)
                }
                Spacer()
            }
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Button {
                        if viewModel.isOBoardingFinished {
                            print("Все выходим")
                            viewModel.finishOB()
                        } else {
                            print("CHECK SUBS")
                            checkSubscribe()
                        }
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
                Text("Stay Connected!")
                    .bigTextStyle(alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 20)
                
                Text("Enable notifications to be the first to know about new features and get inspiration for new creations")
                    .grayTextStyle(alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                Button(action: {
                    requestNotificationPermission()
                }, label: {
                    Text("Turn on notifications")
                        .font(.system(size: 17))
                })
                .buttonStyle(MainButton(width: .infinity, height: 38))
                .padding()
                PageControlView(numberOfPages: 4, currentPage: 2, activeColor: .white, inactiveColor: .white.opacity(0.3)).opacity(0.0)
            }
        }
        .onAppear {
            checkNotificationPermissionStatus()
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $nextViewShow) {
            PayWallView()
        }
    }
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                permissionGranted = granted
                checkSubscribe()
            }
        }
    }
    func checkSubscribe() {
        if SubscriptionService.shared.hasSubs {
            viewModel.finishOB()
        } else {
            nextViewShow.toggle()
        }
    }
    
    func checkNotificationPermissionStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                permissionGranted = settings.authorizationStatus == .authorized
            }
        }
    }
}

#Preview {
    OBView5()
}
