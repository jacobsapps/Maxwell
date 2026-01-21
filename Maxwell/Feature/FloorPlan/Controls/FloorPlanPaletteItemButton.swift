//
//  FloorPlanPaletteItemButton.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanPaletteItemButton: View {
    let item: FloorPlanPaletteItem
    let action: () -> Void

    var body: some View {
        Button(item.title, systemImage: item.systemImage, action: action)
            .frame(maxWidth: .infinity)
            .floorPlanGlassButtonStyle()
    }
}
