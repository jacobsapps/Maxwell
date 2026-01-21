//
//  AppModel.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import Observation

@MainActor
@Observable
final class AppModel {
    let floorPlanBuilder: FloorPlanBuilderViewModel

    init(floorPlanBuilder: FloorPlanBuilderViewModel = FloorPlanBuilderViewModel()) {
        self.floorPlanBuilder = floorPlanBuilder
    }
}
