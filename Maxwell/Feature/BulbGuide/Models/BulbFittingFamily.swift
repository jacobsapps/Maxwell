//
//  BulbFittingFamily.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import Foundation

struct BulbFittingFamily: Identifiable {
    let id = UUID()
    let name: String
    let sizes: [String]
    let typicalUse: String
    let notes: String
    let imageAsset: String
}
