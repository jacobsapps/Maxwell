//
//  FloorPlanGlassPanel.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanGlassPanel<Content: View>: View {
    let cornerRadius: CGFloat
    @ViewBuilder let content: Content

    @ScaledMetric(relativeTo: .body) private var paddingSize: CGFloat = 12

    var body: some View {
        if #available(iOS 26, *) {
            content
                .padding(paddingSize)
                .background(Color.bulbSurface, in: .rect(cornerRadius: cornerRadius))
                .background(BulbGradients.glassSheen, in: .rect(cornerRadius: cornerRadius))
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(Color.bulbEdge.opacity(0.6), lineWidth: BulbMetrics.borderWidth)
                )
                .clipShape(.rect(cornerRadius: cornerRadius))
        } else {
            content
                .padding(paddingSize)
                .background(Color.bulbSurface, in: .rect(cornerRadius: cornerRadius))
                .background(BulbGradients.glassSheen, in: .rect(cornerRadius: cornerRadius))
                .background(.ultraThinMaterial, in: .rect(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(Color.bulbEdge.opacity(0.6), lineWidth: BulbMetrics.borderWidth)
                )
                .clipShape(.rect(cornerRadius: cornerRadius))
        }
    }
}
