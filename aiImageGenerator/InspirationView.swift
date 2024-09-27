import SwiftUI

struct InspirationView: View {
    @EnvironmentObject var imageLoader: ImageLoader
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .top) {
                    Color.bgPrimary
                        .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        Text("Find AI generated images")
                            .bigTextStyle(alignment: .center)
                            .padding(.top, 75)
                            .padding(.bottom, 20)
                        ImageGalleryView(pictures: imageLoader.images)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("aiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 28)
                }
                if !SubscriptionService.shared.hasSubs {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.openPaywall.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 15))
                                Text("Pro")
                                    .font(.system(size: 18))
                                    .bold()
                            }
                        }
                        .buttonStyle(MainButton(width: 72, height: 24, opacity: 0.0))
                        .scaleEffect(0.8)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .tint(.cPrimaryLight)
                    }
                }
            }
        }
    }
}

#Preview {
    InspirationView()
        .environmentObject(ImageLoader())
        .environmentObject(ViewModel())
}


