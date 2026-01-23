//
//  BulbColorOption.swift
//  Maxwell
//
//  Created by Codex on 23/01/2026.
//

import SwiftUI

struct BulbColorOption: Identifiable, Hashable {
    let id: String
    let name: String
    let kelvin: Int
    let color: Color
    let hex: String

    var displayName: String {
        "\(name) \(kelvin)K"
    }

    static let defaultId = "warm-2700"

    static let options: [BulbColorOption] = [
        BulbColorOption(id: "warm-2700", name: "Warm", kelvin: 2700, color: .cct2700, hex: "#FFA757"),
        BulbColorOption(id: "neutral-4000", name: "Neutral", kelvin: 4000, color: .cct4000, hex: "#FFCEA6"),
        BulbColorOption(id: "cool-5000", name: "Cool", kelvin: 5000, color: .cct5000, hex: "#FFE4CE")
    ]

    static var defaultOption: BulbColorOption {
        options.first(where: { $0.id == defaultId }) ?? options[0]
    }

    static func option(for id: String) -> BulbColorOption? {
        options.first(where: { $0.id == id })
    }
}
