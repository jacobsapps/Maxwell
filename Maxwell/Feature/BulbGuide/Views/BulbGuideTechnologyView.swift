//
//  BulbGuideTechnologyView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideTechnologyView: View {
    private let technologies: [BulbTechnologyType] = [
        BulbTechnologyType(
            name: "Incandescent",
            description: "Tungsten filament in a vacuum or inert gas.",
            typicalUses: "General household, decorative",
            notes: "Warm CCT, low efficacy, short life."
        ),
        BulbTechnologyType(
            name: "Halogen",
            description: "Improved incandescent with a halogen gas cycle.",
            typicalUses: "Accent, spotlighting",
            notes: "Higher efficacy than incandescent, hot surface."
        ),
        BulbTechnologyType(
            name: "CFL",
            description: "Compact fluorescent lamp with ballast.",
            typicalUses: "General household and office",
            notes: "Contains mercury and has warm-up time."
        ),
        BulbTechnologyType(
            name: "Linear fluorescent",
            description: "Long tube with ballast (T5/T8/T12).",
            typicalUses: "Offices, industrial",
            notes: "Common G5/G13 bases."
        ),
        BulbTechnologyType(
            name: "LED",
            description: "Light-emitting diodes with driver.",
            typicalUses: "Most modern use cases",
            notes: "High efficacy and many shapes/CCTs."
        ),
        BulbTechnologyType(
            name: "HID (Metal Halide)",
            description: "Arc lamp with metal halide salts.",
            typicalUses: "Outdoor, high-bay",
            notes: "High output with warm-up time."
        ),
        BulbTechnologyType(
            name: "HID (High-Pressure Sodium)",
            description: "Arc lamp with sodium vapor.",
            typicalUses: "Street lighting",
            notes: "Orange hue, high efficacy."
        ),
        BulbTechnologyType(
            name: "HID (Low-Pressure Sodium)",
            description: "Monochromatic sodium light source.",
            typicalUses: "Specialized roadway",
            notes: "Extremely narrow color spectrum."
        ),
        BulbTechnologyType(
            name: "HID (Mercury Vapor)",
            description: "Arc lamp with mercury.",
            typicalUses: "Legacy outdoor lighting",
            notes: "Poor color rendering, long life."
        ),
        BulbTechnologyType(
            name: "Induction",
            description: "Electrodeless fluorescent lamp.",
            typicalUses: "Long-life commercial",
            notes: "Very long life, bulky form factor."
        ),
        BulbTechnologyType(
            name: "OLED",
            description: "Organic LED panels.",
            typicalUses: "Decorative, niche",
            notes: "Thin panels, low brightness."
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BulbSpacing.lg) {
                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Technology types")
                        Text("Technology describes how the bulb creates light, which affects efficiency, heat, and lifespan.")
                            .font(.subheadline)
                            .foregroundStyle(Color.bulbInkMuted)
                    }
                }

                ForEach(technologies) { technology in
                    BulbCard {
                        BulbGuideTechnologyRowView(technology: technology)
                    }
                }
            }
            .padding(BulbSpacing.lg)
        }
        .background(Color.bulbCanvas)
        .navigationTitle("Technology Types")
    }
}
