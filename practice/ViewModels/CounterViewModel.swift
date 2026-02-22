//
//  CounterViewModel.swift
//  practice
//
//  Created by Abdullah Elbokl on 22/02/2026.
//

import Combine
import Foundation

// MARK: - CounterViewModel

/// The ViewModel for the counter screen.
///
/// Responsibilities:
/// - Owns the `Counter` model and exposes reactive state via `@Published`.
/// - Provides formatted display values and UI-relevant computed properties.
/// - Accepts `stepSize` through dependency injection for flexibility.
final class CounterViewModel: ObservableObject {

  // MARK: - Published State

  /// The underlying counter model. Every mutation triggers a UI update.
  @Published private(set) var counter: Counter

  // MARK: - Configuration

  /// The amount to increment or decrement by on each tap.
  let stepSize: Int

  // MARK: - Computed Properties

  /// A formatted string for display (e.g. "42").
  var displayValue: String {
    "\(counter.value)"
  }

  /// Whether the decrement button should be enabled.
  var canDecrement: Bool {
    counter.value > 0
  }

  /// Whether the reset button should be enabled.
  var canReset: Bool {
    counter.value != 0
  }

  // MARK: - Initialization

  /// Creates a new CounterViewModel.
  /// - Parameter stepSize: The increment/decrement step. Defaults to `1`.
  init(stepSize: Int = 1) {
    self.stepSize = stepSize
    self.counter = Counter()
  }

  // MARK: - Actions

  /// Increments the counter by `stepSize`.
  func increment() {
    counter.increment(by: stepSize)
  }

  /// Decrements the counter by `stepSize` (won't go below zero).
  func decrement() {
    counter.decrement(by: stepSize)
  }

  /// Resets the counter to zero.
  func reset() {
    counter.reset()
  }
}
