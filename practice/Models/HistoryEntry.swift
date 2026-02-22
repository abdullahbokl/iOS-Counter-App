import Foundation

struct HistoryEntry: Identifiable {
  let id = UUID()
  let action: Action
  let fromValue: Int
  let toValue: Int
  let stepSize: Int
  let timestamp: Date

  enum Action: String {
    case increment = "Increment"
    case decrement = "Decrement"
    case reset = "Reset"

    var icon: String {
      switch self {
      case .increment: "plus"
      case .decrement: "minus"
      case .reset: "arrow.counterclockwise"
      }
    }
  }
}
