import SwiftUI

// MARK: - Counter View

/// The main screen of the CountUp app displaying the counter value,
/// action buttons, step-size picker, and an action history log.
struct CounterView: View {
  @StateObject private var viewModel = CounterViewModel()

  var body: some View {
    ZStack {
      Color.appBackground
        .ignoresSafeArea()

      ScrollView {
        VStack(spacing: 40) {
          headerSection
          counterDisplaySection
          buttonSection
          stepPickerSection
          historySection
        }
        .padding()
      }
      .scrollIndicators(.hidden)
    }
  }
}

// MARK: - Subviews

extension CounterView {

  /// App title and subtitle.
  private var headerSection: some View {
    VStack(spacing: 4) {
      Text("Counter")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundStyle(Color.primaryText)

      Text("Tap to count")
        .font(.subheadline)
        .foregroundStyle(Color.secondaryText)
    }
    .accessibilityElement(children: .combine)
  }

  /// Large animated counter value display.
  private var counterDisplaySection: some View {
    Text(viewModel.displayValue)
      .font(.system(size: 96, weight: .bold, design: .rounded))
      .foregroundStyle(Color.appAccent)
      .contentTransition(.numericText(value: Double(viewModel.counter.value)))
      .animation(.snappy, value: viewModel.counter.value)
      .accessibilityIdentifier("counterDisplay")
      .accessibilityLabel("Counter value: \(viewModel.displayValue)")
  }

  /// Increment, reset, and decrement action buttons.
  private var buttonSection: some View {
    HStack(spacing: 20) {
      CounterButton(
        title: "Decrement",
        systemImage: "minus",
        color: .decrementColor,
        isEnabled: viewModel.canDecrement,
        action: viewModel.decrement
      )
      .accessibilityIdentifier("decrementButton")

      CounterButton(
        title: "Reset",
        systemImage: "arrow.counterclockwise",
        color: .resetColor,
        isEnabled: viewModel.canReset,
        action: viewModel.reset
      )
      .accessibilityIdentifier("resetButton")

      CounterButton(
        title: "Increment",
        systemImage: "plus",
        color: .incrementColor,
        action: viewModel.increment
      )
      .accessibilityIdentifier("incrementButton")
    }
  }

  /// Segmented picker for selecting the counter step size.
  private var stepPickerSection: some View {
    VStack(spacing: 8) {
      Text("Step Size")
        .font(.footnote)
        .foregroundStyle(Color.secondaryText)

      Picker("Step Size", selection: $viewModel.stepSize) {
        ForEach(CounterViewModel.availableSteps, id: \.self) { step in
          Text("\(step)").tag(step)
        }
      }
      .pickerStyle(.segmented)
      .frame(width: 200)
      .accessibilityIdentifier("stepPicker")
    }
  }

  /// Scrollable list of recent counter actions, shown only when history is non-empty.
  @ViewBuilder
  private var historySection: some View {
    if !viewModel.history.isEmpty {
      VStack(spacing: 12) {
        HStack {
          Text("History")
            .font(.headline)
            .foregroundStyle(Color.primaryText)

          Spacer()

          Button("Clear") {
            viewModel.clearHistory()
          }
          .font(.subheadline)
          .foregroundStyle(Color.secondaryText)
          .accessibilityIdentifier("clearHistoryButton")
        }

        VStack(spacing: 8) {
          ForEach(viewModel.history) { entry in
            HistoryRowView(entry: entry)
          }
        }
      }
      .padding(.top, 8)
      .transition(.opacity)
      .animation(.easeInOut, value: viewModel.history.count)
    }
  }
}

// MARK: - Preview

#Preview {
  CounterView()
}
