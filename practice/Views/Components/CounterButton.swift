import SwiftUI

// MARK: - Counter Button

/// A reusable circular action button used for counter operations.
/// Displays an SF Symbol icon and a label, with an enabled/disabled visual state.
struct CounterButton: View {
    let title: String
    let systemImage: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void

    // MARK: - Initialization

    init(
        title: String,
        systemImage: String,
        color: Color,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.color = color
        self.isEnabled = isEnabled
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.title)
                    .fontWeight(.semibold)

                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(width: 80, height: 80)
            .foregroundStyle(isEnabled ? color : color.opacity(0.3))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color.opacity(isEnabled ? 0.15 : 0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(color.opacity(isEnabled ? 0.3 : 0.1), lineWidth: 1)
            )
        }
        .disabled(!isEnabled)
        .sensoryFeedback(.impact, trigger: isEnabled)
        .accessibilityLabel(title)
    }
}

// MARK: - Preview

#Preview("All States") {
    HStack(spacing: 16) {
        CounterButton(title: "Increment", systemImage: "plus", color: .incrementColor, action: {})
        CounterButton(
            title: "Decrement", systemImage: "minus", color: .decrementColor, isEnabled: false,
            action: {})
        CounterButton(
            title: "Reset", systemImage: "arrow.counterclockwise", color: .resetColor, action: {})
    }
    .padding()
    .background(Color.appBackground)
}
