//
//  BulbGuidePerformanceView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuidePerformanceView: View {
    private let electrical: [BulbSpecItem] = [
        BulbSpecItem(
            title: "Wattage",
            detail: "Power draw in watts. Lower wattage with equal lumens means higher efficiency.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Voltage",
            detail: "Match bulb voltage to fixture voltage to avoid flicker or damage.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Dimmable",
            detail: "Only dimmable bulbs work well with dimmer switches.",
            notes: "Non-dimmable bulbs can flicker or buzz when dimmed."
        ),
        BulbSpecItem(
            title: "Driver type",
            detail: "LEDs include drivers that regulate power and affect dimming behavior.",
            notes: nil
        )
    ]

    private let optics: [BulbSpecItem] = [
        BulbSpecItem(
            title: "Beam angle",
            detail: "Narrow beams are focused; wide beams spread light broadly.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Reflector type",
            detail: "PAR, BR, and MR shapes direct light for spot or flood use.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Diffusion",
            detail: "Clear bulbs are crisp; frosted bulbs soften glare.",
            notes: nil
        )
    ]

    private let performance: [BulbSpecItem] = [
        BulbSpecItem(
            title: "Lumens",
            detail: "Total light output; higher lumens means brighter light.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Efficacy",
            detail: "Measured in lm/W to compare brightness per watt.",
            notes: nil
        ),
        BulbSpecItem(
            title: "CRI (Ra)",
            detail: "Color Rendering Index shows how accurately colors appear.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Lifetime",
            detail: "Rated hours before the bulb fails or dims significantly.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Warm-up time",
            detail: "Some technologies take time to reach full brightness.",
            notes: nil
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BulbSpacing.lg) {
                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Performance & electrical")
                        Text("Compare how bulbs draw power and how efficiently they produce light.")
                            .font(.subheadline)
                            .foregroundStyle(Color.bulbInkMuted)
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Electrical")
                        ForEach(electrical) { item in
                            BulbGuideSpecRowView(item: item)
                        }
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Optics")
                        ForEach(optics) { item in
                            BulbGuideSpecRowView(item: item)
                        }
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Performance")
                        ForEach(performance) { item in
                            BulbGuideSpecRowView(item: item)
                        }
                    }
                }
            }
            .padding(BulbSpacing.lg)
        }
        .background(Color.bulbCanvas)
        .navigationTitle("Performance")
    }
}
