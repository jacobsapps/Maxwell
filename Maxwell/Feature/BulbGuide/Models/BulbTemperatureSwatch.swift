//
//  BulbTemperatureSwatch.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbTemperatureSwatch: Identifiable {
    let id = UUID()
    let kelvin: Int
    let description: String
    let hex: String
    let color: Color
    let tone: BulbChipTone
}
