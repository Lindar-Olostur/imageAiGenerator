import SwiftUI

struct StyleCellView: View {
    let active: Bool
    let label: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(label)
                .font(.system(size: 17))
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(active ? Color.bgQuoternary : Color.clear)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(active ? Color.cPrimaryLight : Color.gray.opacity(0.24), lineWidth: 1)
                )
                .foregroundColor(active ? .white : .lSecondary)
        }
    }
}

#Preview {
    StyleCellView(active: true, label: "🎨 Art", onTap: {})
}
