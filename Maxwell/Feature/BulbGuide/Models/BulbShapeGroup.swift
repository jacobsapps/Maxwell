//
//  BulbShapeGroup.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import Foundation

struct BulbShapeGroup: Identifiable {
    let id = UUID()
    let title: String
    let entries: [BulbShapeEntry]
}
