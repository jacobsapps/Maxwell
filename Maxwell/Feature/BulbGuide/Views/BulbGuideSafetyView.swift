//
//  BulbGuideSafetyView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideSafetyView: View {
    private let safetyItems: [BulbSpecItem] = [
        BulbSpecItem(
            title: "Certifications",
            detail: "Look for UL, ETL, or CE marks to confirm safety compliance.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Enclosure ratings",
            detail: "Wet or damp location ratings indicate where the bulb can be used safely.",
            notes: nil
        ),
        BulbSpecItem(
            title: "Mercury content",
            detail: "CFL and fluorescent lamps contain mercury and need proper disposal.",
            notes: nil
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BulbSpacing.lg) {
                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Safety & compliance")
                        Text("Pay attention to certifications and materials when choosing bulbs.")
                            .font(.subheadline)
                            .foregroundStyle(Color.bulbInkMuted)
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        ForEach(safetyItems) { item in
                            BulbGuideSpecRowView(item: item)
                        }
                    }
                }
            }
            .padding(BulbSpacing.lg)
        }
        .background(Color.bulbCanvas)
        .navigationTitle("Safety")
    }
}
