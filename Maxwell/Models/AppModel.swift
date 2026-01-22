//
//  AppModel.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import Factory
import Observation

@MainActor
@Observable
final class AppModel {
    let floorPlanBuilder: FloorPlanBuilderViewModel

    init(floorPlanBuilder: FloorPlanBuilderViewModel = FloorPlanBuilderViewModel(store: Container.shared.maxwellDataStore())) {
        self.floorPlanBuilder = floorPlanBuilder
    }
}
