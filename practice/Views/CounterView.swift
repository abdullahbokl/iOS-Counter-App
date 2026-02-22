//
//  CounterView.swift
//  practice
//
//  Created by Abdullah Elbokl on 22/02/2026.
//

import SwiftUI

// MARK: - CounterView

/// The main counter screen.
///
/// This view owns the `CounterViewModel` via `@StateObject`,
/// meaning it is the single source of truth for the counter state.
/// It composes reusable `CounterButton` components for each action.
struct CounterView: View {

  // MARK: - State

  /// The ViewModel that drives this view.
  /// `@StateObject` ensures it survives SwiftUI view re-creation.
  @StateObject private var viewModel = CounterViewModel()

  // MARK: - Body

  var body: some View {
    ZStack {
      // Background
      Color.appBackground
        .ignoresSafeArea()

      VStack(spacing: 40) {
        headerSection
        counterDisplaySection
        buttonSection
        stepInfoSection
      }
      .padding()
    }
  }
}

// MARK: - Subviews

extension CounterView {

  /// The app title at the top of the screen.
  fileprivate var headerSection: some View {
    VStack(spacing: 4) {
      Text("Counter")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundStyle(Color.primaryText)

      Text("Tap to count")
        .font(.subheadline)
        .foregroundStyle(Color.secondaryText)
    }
  }

  /// The large counter value display with animation.
  fileprivate var counterDisplaySection: some View {
    Text(viewModel.displayValue)
      .font(.system(size: 96, weight: .bold, design: .rounded))
      .foregroundStyle(Color.appAccent)
      .contentTransition(.numericText(value: Double(viewModel.counter.value)))
      .animation(.snappy, value: viewModel.counter.value)
  }

  /// The row of action buttons.
  fileprivate var buttonSection: some View {
    HStack(spacing: 20) {
      CounterButton(
        title: "Decrement",
        systemImage: "minus",
        color: .decrementColor,
        isEnabled: viewModel.canDecrement,
        action: viewModel.decrement
      )

      CounterButton(
        title: "Reset",
        systemImage: "arrow.counterclockwise",
        color: .resetColor,
        isEnabled: viewModel.canReset,
        action: viewModel.reset
      )

      CounterButton(
        title: "Increment",
        systemImage: "plus",
        color: .incrementColor,
        action: viewModel.increment
      )
    }
  }

  /// Displays the current step size for transparency.
  fileprivate var stepInfoSection: some View {
    Text("Step: \(viewModel.stepSize)")
      .font(.footnote)
      .foregroundStyle(Color.secondaryText)
  }
}

// MARK: - Preview

#Preview {
  CounterView()
}
