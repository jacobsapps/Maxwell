//
//  SummaryRoomRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct SummaryRoomRowView: View {
    let roomTitle: String
    let bulbs: [FloorPlanBulb]
    let bulbTitle: (Int) -> String

    var body: some View {
        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
            Label(roomTitle, systemImage: "square.grid.2x2")
                .font(.headline)
            if bulbs.isEmpty {
                Text("No bulbs yet")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: BulbSpacing.sm) {
                        ForEach(bulbs.enumerated(), id: \.element.id) { index, _ in
                            Text(bulbTitle(index))
                                .font(.caption)
                                .padding(.horizontal, BulbSpacing.sm)
                                .padding(.vertical, BulbSpacing.xs)
                                .background(.thinMaterial, in: .capsule)
                        }
                    }
                    .padding(.vertical, BulbSpacing.xs)
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(.vertical, BulbSpacing.xs)
    }
}
