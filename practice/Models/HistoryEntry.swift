import Foundation

// MARK: - History Entry Model

/// Represents a single recorded counter action with before/after values and a timestamp.
struct HistoryEntry: Identifiable, Equatable {
    let id = UUID()
    let action: Action
    let fromValue: Int
    let toValue: Int
    let stepSize: Int
    let timestamp: Date

    // MARK: - Equatable

    static func == (lhs: HistoryEntry, rhs: HistoryEntry) -> Bool {
        lhs.id == rhs.id
    }

    // MARK: - Action

    /// The type of counter action that was performed.
    enum Action: String {
        case increment = "Increment"
        case decrement = "Decrement"
        case reset = "Reset"

        /// SF Symbol name for this action type.
        var icon: String {
            switch self {
            case .increment: "plus"
            case .decrement: "minus"
            case .reset: "arrow.counterclockwise"
            }
        }
    }
}
