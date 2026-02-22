import Combine
import Foundation

final class CounterViewModel: ObservableObject {

  @Published private(set) var counter = Counter()
  @Published private(set) var history: [HistoryEntry] = []

  static let maxHistoryCount = 10

  static let availableSteps = [1, 5, 10]

  @Published var stepSize: Int

  var displayValue: String {
    "\(counter.value)"
  }

  var canDecrement: Bool {
    counter.value > 0
  }

  var canReset: Bool {
    counter.value != 0
  }

  init(stepSize: Int = 1) {
    self.stepSize = stepSize
  }

  func updateStepSize(_ newStepSize: Int) {
    stepSize = newStepSize
  }

  func increment() {
    record(.increment) {
      counter.increment(by: stepSize)
    }
  }

  func decrement() {
    record(.decrement) {
      counter.decrement(by: stepSize)
    }
  }

  func reset() {
    record(.reset) {
      counter.reset()
    }
  }

  func clearHistory() {
    history.removeAll()
  }

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
