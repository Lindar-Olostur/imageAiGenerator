import SwiftUI

struct CheckboxButton: View {
    @Binding var isChecked: Bool
    let isActive: Bool
    let isTrial: Bool
    let period: SubsPeriod
    let priseFull: String
    let priseWeek: String
    
    var body: some View {
        Button {
            isChecked = isActive
        } label: {
            
            HStack {
                Circle()
                    .stroke(isChecked == isActive ? Color.cPrimaryLight : Color.lQuintuple, lineWidth: 2)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .fill(Color.cPrimaryLight)
                            .opacity(isChecked == isActive ? 1 : 0)
                            .frame(width: 16, height: 16)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(period.rawValue)
                            .font(.system(size: 12))
                            .foregroundColor(.lSecondary)
                        Text(priseFull)
                            .font(.system(size: 12))
                            .foregroundColor(.lQuoternary)
                    }
                    Text("\(priseWeek) / week")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                }
                Spacer()
                
                if isTrial {
                    HStack {
                        Rectangle()
                            .frame(width: 1, height: 36)
                            .foregroundColor(Color.lTertiary).opacity(0.5)
                            .padding(.trailing)
                        VStack {
                            Text("3 days")
                                .font(.caption)
                                .foregroundColor(.cPrimaryLight)
                            Text("free")
                                .font(.caption)
                                .foregroundColor(.cPrimaryLight)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(isChecked == isActive ? Color.bgQuoternary : Color.bgTertiary)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.cPrimaryLight, lineWidth: isChecked == isActive ? 1 : 0)
            )
            .padding(.horizontal)
        }
    }
}

#Preview {
    CheckboxButton(isChecked: .constant(false), isActive: false, isTrial: true, period: .yearly, priseFull: "$39.99", priseWeek: "$1.87")
}

enum SubsPeriod: String {
    case monthly = "Monthly"
    case yearly = "Yearly"
}
