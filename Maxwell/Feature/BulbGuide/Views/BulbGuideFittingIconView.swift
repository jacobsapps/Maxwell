//
//  BulbGuideFittingIconView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideFittingIconView: View {
    let assetName: String
    let size: CGFloat

    init(assetName: String, size: CGFloat = 44) {
        self.assetName = assetName
        self.size = size
    }

    var body: some View {
        Image(assetName)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundStyle(Color.bulbInk)
            .padding(BulbSpacing.xs)
            .background(Color.bulbSurface, in: .rect(cornerRadius: BulbMetrics.smallCornerRadius))
            .clipShape(.rect(cornerRadius: BulbMetrics.smallCornerRadius))
    }
}
