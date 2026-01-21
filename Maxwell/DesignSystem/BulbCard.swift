//
//  BulbCard.swift
//  Maxwell
//
//  Created by Codex on 21/01/2026.
//

import SwiftUI

struct BulbCard<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(BulbSpacing.md)
            .background(Color.bulbSurface, in: .rect(cornerRadius: BulbMetrics.cornerRadius))
            .background(BulbGradients.glassSheen, in: .rect(cornerRadius: BulbMetrics.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: BulbMetrics.cornerRadius, style: .continuous)
                    .stroke(Color.bulbEdge.opacity(0.6), lineWidth: BulbMetrics.borderWidth)
            )
            .clipShape(.rect(cornerRadius: BulbMetrics.cornerRadius))
    }
}
