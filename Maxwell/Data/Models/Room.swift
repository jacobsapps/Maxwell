import Foundation
import SQLiteData

@Table("rooms")
struct Room: Codable, Identifiable, Sendable {
    var id: UUID
    var floorId: UUID
    var name: String
    var orderIndex: Int
    var transformTranslationX: Double
    var transformTranslationY: Double
    var transformRotationRadians: Double
    var transformScale: Double

    init(
        id: UUID = UUID(),
        floorId: UUID,
        name: String,
        orderIndex: Int,
        transformTranslationX: Double = 0,
        transformTranslationY: Double = 0,
        transformRotationRadians: Double = 0,
        transformScale: Double = 1
    ) {
        self.id = id
        self.floorId = floorId
        self.name = name
        self.orderIndex = orderIndex
        self.transformTranslationX = transformTranslationX
        self.transformTranslationY = transformTranslationY
        self.transformRotationRadians = transformRotationRadians
        self.transformScale = transformScale
    }
}
