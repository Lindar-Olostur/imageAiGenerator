import SwiftUI

struct OBView2: View {
    
    var body: some View {
        NavigationStack {
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
                    Image("OB2")
                        .resizable()
                        .aspectRatio(3/5, contentMode: .fit)
                        .padding(.horizontal, 40)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.clear, location: 0),
                                    .init(color: Color(.bgPrimary), location: 0.750002)
                                ]),
                                startPoint: UnitPoint(x: 0.5002, y: 0.6002),
                                endPoint: .bottom
                            )
                        )
                    Spacer()
                }
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("Explore a World of Creativity!")
                        .bigTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 20)
                    
                    Text("Discover thousands of images created by other users and get inspired by their ideas")
                        .grayTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    NavigationLink(destination: OBView3()) {
                        Text("Continue")
                            .font(.system(size: 17))
                    }
                    .buttonStyle(MainButton(width: .infinity, height: 38))
                    .padding()
                    PageControlView(numberOfPages: 4, currentPage: 1, activeColor: .white, inactiveColor: .white.opacity(0.3))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OBView2()
}
