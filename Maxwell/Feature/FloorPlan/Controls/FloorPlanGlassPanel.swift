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
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: cornerRadius))
        } else {
            content
                .padding(paddingSize)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}
