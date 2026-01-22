//
//  FloorPlanCanvasTransform.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct FloorPlanCanvasTransform: Equatable {
    var scale: CGFloat = 1
    var rotation: Angle = .zero
    var offset: CGSize = .zero

    static let identity = FloorPlanCanvasTransform()

    var isIdentity: Bool {
        self == Self.identity
    }
}
