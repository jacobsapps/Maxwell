//
//  FloorPlanGlassButtonStyleModifier.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct FloorPlanGlassButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.buttonStyle(BulbGhostButtonStyle())
    }
}

extension View {
    func floorPlanGlassButtonStyle() -> some View {
        modifier(FloorPlanGlassButtonStyleModifier())
    }
}
