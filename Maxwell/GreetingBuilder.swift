//
//  GreetingBuilder.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 20/01/2026.
//

import Foundation

struct GreetingBuilder {
    static func greeting(name: String) -> String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Hello!" : "Hello, \(trimmed)!"
    }
}
