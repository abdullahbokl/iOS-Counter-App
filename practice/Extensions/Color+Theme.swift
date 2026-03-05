import SwiftUI

// MARK: - Design System Colors

/// Centralized color palette for the CountUp app.
/// All colors use HSL for consistent theming across the dark-mode interface.
extension Color {

  // MARK: - Brand

  static let appAccent = Color(hue: 0.60, saturation: 0.75, brightness: 0.95)
  static let appBackground = Color(hue: 0.70, saturation: 0.08, brightness: 0.12)

  // MARK: - Action Colors

  static let incrementColor = Color(hue: 0.38, saturation: 0.70, brightness: 0.80)
  static let decrementColor = Color(hue: 0.02, saturation: 0.70, brightness: 0.90)
  static let resetColor = Color(hue: 0.08, saturation: 0.60, brightness: 0.95)

  // MARK: - Text & Surface

  static let primaryText = Color.white
  static let secondaryText = Color.white.opacity(0.6)
  static let surfaceColor = Color.white.opacity(0.08)
}
