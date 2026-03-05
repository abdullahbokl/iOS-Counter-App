import Combine
import Foundation

// MARK: - Counter ViewModel

/// Manages the counter state and history, serving as the single source of truth
/// for all counter-related UI. Follows the MVVM pattern with `@Published` properties.
final class CounterViewModel: ObservableObject {

  // MARK: - Published State

  @Published private(set) var counter = Counter()
  @Published private(set) var history: [HistoryEntry] = []
  @Published var stepSize: Int

  // MARK: - Constants

  static let maxHistoryCount = 10
  static let availableSteps = [1, 5, 10]

  // MARK: - Computed Properties

  /// The current counter value formatted for display.
  var displayValue: String {
    "\(counter.value)"
  }

  /// Whether the counter can be decremented (value > 0).
  var canDecrement: Bool {
    counter.value > 0
  }

  /// Whether the counter can be reset (value ≠ 0).
  var canReset: Bool {
    counter.value != 0
  }

  // MARK: - Initialization

  init(stepSize: Int = 1) {
    self.stepSize = stepSize
  }

  // MARK: - Actions

  /// Increments the counter by the current step size and records the action.
  func increment() {
    record(.increment) {
      counter.increment(by: stepSize)
    }
  }

  /// Decrements the counter by the current step size and records the action.
  func decrement() {
    record(.decrement) {
      counter.decrement(by: stepSize)
    }
  }

  /// Resets the counter to zero and records the action.
  func reset() {
    record(.reset) {
      counter.reset()
    }
  }

  /// Removes all entries from the history log.
  func clearHistory() {
    history.removeAll()
  }

  // MARK: - Private Helpers

  /// Records a counter mutation into the history log, keeping only the most recent entries.
  private func record(_ action: HistoryEntry.Action, mutation: () -> Void) {
    let previousValue = counter.value
    mutation()
    let entry = HistoryEntry(
      action: action,
      fromValue: previousValue,
      toValue: counter.value,
      stepSize: stepSize,
      timestamp: Date()
    )
    history.insert(entry, at: 0)
    if history.count > Self.maxHistoryCount {
      history.removeLast()
    }
  }
}
