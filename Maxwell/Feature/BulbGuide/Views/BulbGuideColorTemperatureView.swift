//
//  BulbGuideColorTemperatureView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideColorTemperatureView: View {
    private let swatches: [BulbTemperatureSwatch] = [
        BulbTemperatureSwatch(kelvin: 1800, description: "Candlelight / ultra warm", hex: "#FF7E00", color: .cct1800, tone: .warm),
        BulbTemperatureSwatch(kelvin: 2200, description: "Very warm", hex: "#FF9227", color: .cct2200, tone: .warm),
        BulbTemperatureSwatch(kelvin: 2400, description: "Warm", hex: "#FF9B3D", color: .cct2400, tone: .warm),
        BulbTemperatureSwatch(kelvin: 2700, description: "Soft warm (incandescent)", hex: "#FFA757", color: .cct2700, tone: .warm),
        BulbTemperatureSwatch(kelvin: 3000, description: "Warm white", hex: "#FFB16E", color: .cct3000, tone: .warm),
        BulbTemperatureSwatch(kelvin: 3500, description: "Neutral warm", hex: "#FFC18D", color: .cct3500, tone: .neutral),
        BulbTemperatureSwatch(kelvin: 4000, description: "Neutral white", hex: "#FFCEA6", color: .cct4000, tone: .neutral),
        BulbTemperatureSwatch(kelvin: 4500, description: "Cool white", hex: "#FFDABB", color: .cct4500, tone: .neutral),
        BulbTemperatureSwatch(kelvin: 5000, description: "Daylight white", hex: "#FFE4CE", color: .cct5000, tone: .cool),
        BulbTemperatureSwatch(kelvin: 5500, description: "Daylight", hex: "#FFEDDE", color: .cct5500, tone: .cool),
        BulbTemperatureSwatch(kelvin: 6500, description: "Cool daylight", hex: "#FFFEFA", color: .cct6500, tone: .cool),
        BulbTemperatureSwatch(kelvin: 7500, description: "Overcast sky", hex: "#E6EBFF", color: .cct7500, tone: .cool)
    ]

    private let guidance: [BulbSpecItem] = [
        BulbSpecItem(
            title: "Warm ranges",
            detail: "1800K to 3000K feels cozy and amber, ideal for living areas and hospitality.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Neutral ranges",
            detail: "3500K to 4500K reads balanced and clean, great for kitchens and baths.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Cool ranges",
            detail: "5000K to 6500K feels crisp and focused, often used for task lighting.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Brightness is separate",
            detail: "Kelvin describes color, while brightness is measured in lumens.",
            notes: nil
        )
    ]

    @State private var selectedSwatch: BulbTemperatureSwatch?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BulbSpacing.lg) {
                GroupBox {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        Text("Color temperature (CCT) describes the warmth of a bulb on the Kelvin scale.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } label: {
                    Text("Color temperature")
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        ForEach(swatches) { swatch in
                            Button {
                                selectedSwatch = swatch
                            } label: {
                                BulbGuideTemperatureRowView(swatch: swatch)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(Text("\(swatch.kelvin) Kelvin swatch"))
                        }
                    }
                } label: {
                    Text("Kelvin swatches")
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        ForEach(guidance) { item in
                            BulbGuideSpecRowView(item: item)
                        }
                    }
                } label: {
                    Text("Choosing the right range")
                }
            }
            .padding(BulbSpacing.lg)
        }
        .navigationTitle("Color Temperature")
        .fullScreenCover(item: $selectedSwatch) { swatch in
            BulbGuideTemperatureSwatchFullScreenView(swatch: swatch)
        }
    }
}
