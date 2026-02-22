//
//  Color+Theme.swift
//  practice
//
//  Created by Abdullah Elbokl on 22/02/2026.
//

import SwiftUI

// MARK: - App Theme Colors

/// Extends `Color` with a centralized palette so we avoid
/// scattering magic color values throughout the codebase.
extension Color {

  // MARK: - Brand

  static let appAccent = Color(hue: 0.60, saturation: 0.75, brightness: 0.95)  // Vibrant blue
  static let appBackground = Color(hue: 0.70, saturation: 0.08, brightness: 0.12)  // Deep dark

  // MARK: - Counter Actions

  static let incrementColor = Color(hue: 0.38, saturation: 0.70, brightness: 0.80)  // Teal-green
  static let decrementColor = Color(hue: 0.02, saturation: 0.70, brightness: 0.90)  // Warm coral
  static let resetColor = Color(hue: 0.08, saturation: 0.60, brightness: 0.95)  // Amber

  // MARK: - Text

  static let primaryText = Color.white
  static let secondaryText = Color.white.opacity(0.6)
}
