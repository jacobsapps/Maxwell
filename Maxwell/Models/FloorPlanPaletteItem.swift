//
//  FloorPlanPaletteItem.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

enum FloorPlanPaletteItem: String, CaseIterable, Identifiable {
    case room
    case bulb

    var id: String { rawValue }

    var title: String {
        switch self {
        case .room:
            return "Room"
        case .bulb:
            return "Light"
        }
    }

    var systemImage: String {
        switch self {
        case .room:
            return "square.grid.2x2"
        case .bulb:
            return "lightbulb"
        }
    }

    var defaultSize: CGSize {
        switch self {
        case .room:
            return CGSize(width: 180, height: 120)
        case .bulb:
            return CGSize(width: 24, height: 24)
        }
    }
}
