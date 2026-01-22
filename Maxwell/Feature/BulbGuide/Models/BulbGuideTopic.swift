//
//  BulbGuideTopic.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import Foundation

struct BulbGuideTopic: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let systemImage: String
    let destination: BulbGuideDestination
}
