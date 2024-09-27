import SwiftUI

struct OBView3: View {
    
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
                    Image("OB3")
                        .resizable()
                        .aspectRatio(3/5, contentMode: .fit)
                        .padding(.horizontal, 40)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.clear, location: 0),
                                    .init(color: Color(.bgPrimary), location: 0.7500003)
                                ]),
                                startPoint: UnitPoint(x: 0.5003, y: 0.6003),
                                endPoint: .bottom
                            )
                        )
                    Spacer()
                }
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("Remove Backgrounds with a Single Tap")
                        .bigTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 20)
                    
                    Text("Easily remove backgrounds to make your images sharper and more expressive")
                        .grayTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    NavigationLink(destination: OBView4()) {
                        Text("Continue")
                            .font(.system(size: 17))
                    }
                    .buttonStyle(MainButton(width: .infinity, height: 38))
                    .padding()
                    PageControlView(numberOfPages: 4, currentPage: 2, activeColor: .white, inactiveColor: .white.opacity(0.3))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OBView3()
}
