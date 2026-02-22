import SwiftUI

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

  fileprivate var stepPickerSection: some View {
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
    }
  }

  @ViewBuilder
  fileprivate var historySection: some View {
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
        }

        VStack(spacing: 8) {
          ForEach(viewModel.history) { entry in
            HistoryRow(entry: entry)
          }
        }
      }
      .padding(.top, 8)
      .transition(.opacity)
      .animation(.easeInOut, value: viewModel.history.count)
    }
  }
}

// MARK: - HistoryRow

private struct HistoryRow: View {
  let entry: HistoryEntry

  private var actionColor: Color {
    switch entry.action {
    case .increment: .incrementColor
    case .decrement: .decrementColor
    case .reset: .resetColor
    }
  }

  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: entry.action.icon)
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundStyle(actionColor)
        .frame(width: 28, height: 28)
        .background(actionColor.opacity(0.15), in: RoundedRectangle(cornerRadius: 8))

      Text(entry.action.rawValue)
        .font(.subheadline)
        .foregroundStyle(Color.primaryText)

      Text("\(entry.fromValue) → \(entry.toValue)")
        .font(.subheadline)
        .foregroundStyle(Color.secondaryText)

      Spacer()

      Text(entry.timestamp, format: .dateTime.hour().minute().second())
        .font(.caption2)
        .foregroundStyle(Color.secondaryText)
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 10)
    .background(Color.surfaceColor, in: RoundedRectangle(cornerRadius: 12))
  }
}

#Preview {
  CounterView()
}
