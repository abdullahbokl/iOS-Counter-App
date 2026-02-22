//
//  Counter.swift
//  practice
//
//  Created by Abdullah Elbokl on 22/02/2026.
//

import Foundation

// MARK: - Counter Model

/// A value type representing a simple counter.
/// Encapsulates the counter's state and mutations,
/// keeping business rules (e.g. non-negative) at the model level.
struct Counter {

  // MARK: - Properties

  private(set) var value: Int

  // MARK: - Initialization

  init(value: Int = 0) {
    self.value = value
  }

  // MARK: - Mutations

  /// Increments the counter by the given step.
  mutating func increment(by step: Int = 1) {
    value += step
  }

  /// Decrements the counter by the given step.
  /// The value will never go below zero.
  mutating func decrement(by step: Int = 1) {
    value = max(0, value - step)
  }

  /// Resets the counter back to zero.
  mutating func reset() {
    value = 0
  }
}

struct counter2 {

  private(set) var value: Int

  init(value: Int = 0) {
    self.value = value
  }

  mutating func inc(incValue value: Int = 1) {
    self.value += value
  }

}
