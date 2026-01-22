//
//  FloorPlanCanvasBackgroundView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanCanvasBackgroundView: View {
    var body: some View {
        Rectangle()
            .fill(Color.bulbCanvas)
            .overlay {
                Rectangle()
                    .fill(BulbGradients.glassSheen)
                    .opacity(0.35)
            }
    }
}
