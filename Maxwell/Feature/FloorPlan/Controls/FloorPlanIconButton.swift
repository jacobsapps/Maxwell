//
//  FloorPlanIconButton.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanIconButton: View {
    let symbol: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(label, systemImage: symbol, action: action)
            .font(.caption)
            .frame(maxWidth: .infinity)
            .floorPlanGlassButtonStyle()
    }
}
