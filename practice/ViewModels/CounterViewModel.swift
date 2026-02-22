import Combine
import Foundation

final class CounterViewModel: ObservableObject {

  @Published private(set) var counter = Counter()

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
    counter.increment(by: stepSize)
  }

  func decrement() {
    counter.decrement(by: stepSize)
  }

  func reset() {
    counter.reset()
  }
}
