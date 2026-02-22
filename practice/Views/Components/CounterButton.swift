//
//  CounterButton.swift
//  practice
//
//  Created by Abdullah Elbokl on 22/02/2026.
//

import SwiftUI

// MARK: - CounterButton

/// A reusable, styled button for counter actions.
///
/// Designed to be configured with any icon, label, and color —
/// making it open for extension without modification (Open/Closed).
///
/// Usage:
/// ```swift
/// CounterButton(
///     title: "Increment",
///     systemImage: "plus",
///     color: .incrementColor,
///     action: { viewModel.increment() }
/// )
/// ```
struct CounterButton: View {

  // MARK: - Properties

  let title: String
  let systemImage: String
  let color: Color
  let isEnabled: Bool
  let action: () -> Void

  // MARK: - Initialization

  /// Creates a new CounterButton.
  /// - Parameters:
  ///   - title: The accessibility label shown below the icon.
  ///   - systemImage: An SF Symbol name for the button icon.
  ///   - color: The tint color for the button.
  ///   - isEnabled: Whether the button is interactive. Defaults to `true`.
  ///   - action: The closure to execute on tap.
  init(
    title: String,
    systemImage: String,
    color: Color,
    isEnabled: Bool = true,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.systemImage = systemImage
    self.color = color
    self.isEnabled = isEnabled
    self.action = action
  }

  // MARK: - Body

  var body: some View {
    Button(action: action) {
      VStack(spacing: 8) {
        Image(systemName: systemImage)
          .font(.title)
          .fontWeight(.semibold)

        Text(title)
          .font(.caption)
          .fontWeight(.medium)
      }
      .frame(width: 80, height: 80)
      .foregroundStyle(isEnabled ? color : color.opacity(0.3))
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(color.opacity(isEnabled ? 0.15 : 0.05))
      )
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .strokeBorder(color.opacity(isEnabled ? 0.3 : 0.1), lineWidth: 1)
      )
    }
    .disabled(!isEnabled)
    .sensoryFeedback(.impact, trigger: isEnabled)
  }
}

// MARK: - Preview

#Preview("All States") {
  HStack(spacing: 16) {
    CounterButton(
      title: "Increment",
      systemImage: "plus",
      color: .incrementColor,
      action: {}
    )

    CounterButton(
      title: "Decrement",
      systemImage: "minus",
      color: .decrementColor,
      isEnabled: false,
      action: {}
    )

    CounterButton(
      title: "Reset",
      systemImage: "arrow.counterclockwise",
      color: .resetColor,
      action: {}
    )
  }
  .padding()
  .background(Color.appBackground)
}
