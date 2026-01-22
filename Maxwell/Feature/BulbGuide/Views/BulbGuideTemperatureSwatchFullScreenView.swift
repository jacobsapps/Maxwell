//
//  BulbGuideTemperatureSwatchFullScreenView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI
import UIKit

struct BulbGuideTemperatureSwatchFullScreenView: View {
    let swatch: BulbTemperatureSwatch
    @State private var previousBrightness: CGFloat?

    var body: some View {
        swatch.color
            .ignoresSafeArea()
            .onAppear {
                guard let screen = currentScreen() else { return }
                previousBrightness = screen.brightness
                screen.brightness = 1.0
            }
            .onDisappear {
                guard let screen = currentScreen(), let previousBrightness else { return }
                screen.brightness = previousBrightness
            }
            .accessibilityLabel(Text("\(swatch.kelvin) Kelvin swatch"))
    }

    private func currentScreen() -> UIScreen? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first(where: { $0.activationState == .foregroundActive })?
            .screen
    }
}
