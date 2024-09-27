import SwiftUI

struct ToastView: View {
    @Binding var text: String
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.green)
                .padding(.trailing, -8)
                .padding(.leading, 8)
            Text(text)
                .font(.system(size: 12))
                .padding(8)
                .foregroundColor(.black)
                .padding(.trailing, 4)

        }
        .background(
            Capsule()
                .fill(.white)
        )
    }
}

#Preview {
    ToastView(text: .constant("Saved to gallery"))
}
