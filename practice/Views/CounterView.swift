import SwiftUI

struct CounterView: View {
  @StateObject private var viewModel = CounterViewModel()

  var body: some View {
    ZStack {
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

  fileprivate var counterDisplaySection: some View {
    Text(viewModel.displayValue)
      .font(.system(size: 96, weight: .bold, design: .rounded))
      .foregroundStyle(Color.appAccent)
      .contentTransition(.numericText(value: Double(viewModel.counter.value)))
      .animation(.snappy, value: viewModel.counter.value)
  }

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

  fileprivate var stepInfoSection: some View {
    Text("Step: \(viewModel.stepSize)")
      .font(.footnote)
      .foregroundStyle(Color.secondaryText)
  }
}

#Preview {
  CounterView()
}
