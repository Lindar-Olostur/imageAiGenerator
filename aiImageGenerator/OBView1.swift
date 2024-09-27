import SwiftUI

struct OBView1: View {
    
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
                    Image("OB1")
                        .resizable()
                        .aspectRatio(3/5, contentMode: .fit)
                        .padding(.horizontal, 40)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.clear, location: 0),
                                    .init(color: Color(.bgPrimary), location: 0.75001)
                                ]),
                                startPoint: UnitPoint(x: 0.501, y: 0.601),
                                endPoint: .bottom
                            )
                        )
                    Spacer()
                }
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("Create Images with AI in Seconds!")
                        .bigTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 4)
                    
                    Text("Enter a description, and our AI will instantly turn your words into unique images")
                        .grayTextStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    
                    NavigationLink(destination: OBView2()) {
                        Text("Continue")
                            .font(.system(size: 17))
                    }
                    .buttonStyle(MainButton(width: .infinity, height: 38))
                    .padding()
                    
                    PageControlView(numberOfPages: 4, currentPage: 0, activeColor: .white, inactiveColor: .white.opacity(0.3))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OBView1()
}
