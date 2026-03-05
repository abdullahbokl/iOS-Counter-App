import SwiftUI

// MARK: - History Row View

/// Displays a single history entry with its action icon, label, value transition, and timestamp.
struct HistoryRowView: View {
  let entry: HistoryEntry

  // MARK: - Private Helpers

  private var actionColor: Color {
    switch entry.action {
    case .increment: .incrementColor
    case .decrement: .decrementColor
    case .reset: .resetColor
    }
  }

  // MARK: - Body

  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: entry.action.icon)
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundStyle(actionColor)
        .frame(width: 28, height: 28)
        .background(actionColor.opacity(0.15), in: RoundedRectangle(cornerRadius: 8))

      Text(entry.action.rawValue)
        .font(.subheadline)
        .foregroundStyle(Color.primaryText)

      Text("\(entry.fromValue) → \(entry.toValue)")
        .font(.subheadline)
        .foregroundStyle(Color.secondaryText)

      Spacer()

      Text(entry.timestamp, format: .dateTime.hour().minute().second())
        .font(.caption2)
        .foregroundStyle(Color.secondaryText)
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 10)
    .background(Color.surfaceColor, in: RoundedRectangle(cornerRadius: 12))
    .accessibilityElement(children: .combine)
    .accessibilityLabel("\(entry.action.rawValue) from \(entry.fromValue) to \(entry.toValue)")
  }
}

// MARK: - Preview

#Preview {
  VStack {
    HistoryRowView(
      entry: HistoryEntry(
        action: .increment,
        fromValue: 0,
        toValue: 5,
        stepSize: 5,
        timestamp: Date()
      )
    )
    HistoryRowView(
      entry: HistoryEntry(
        action: .decrement,
        fromValue: 5,
        toValue: 4,
        stepSize: 1,
        timestamp: Date()
      )
    )
    HistoryRowView(
      entry: HistoryEntry(
        action: .reset,
        fromValue: 4,
        toValue: 0,
        stepSize: 1,
        timestamp: Date()
      )
    )
  }
  .padding()
  .background(Color.appBackground)
}
