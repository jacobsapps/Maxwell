//
//  BulbGuideTechnologyRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideTechnologyRowView: View {
    let technology: BulbTechnologyType

    var body: some View {
        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
            Text(technology.name)
                .font(.headline)
                .foregroundStyle(Color.bulbInk)
            Text(technology.description)
                .font(.subheadline)
                .foregroundStyle(Color.bulbInkMuted)
            Text("Typical uses: \(technology.typicalUses)")
                .font(.caption)
                .foregroundStyle(Color.bulbInkMuted)
            Text(technology.notes)
                .font(.caption)
                .foregroundStyle(Color.bulbInkMuted)
        }
    }
}
