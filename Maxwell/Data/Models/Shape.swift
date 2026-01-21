import Foundation
import SQLiteData

@Table("shapes")
struct Shape: Codable, Identifiable, Sendable {
    var id: UUID
    var roomId: UUID
    var shapeType: ShapeType
    var sizeWidth: Double
    var sizeHeight: Double
    var localPositionX: Double
    var localPositionY: Double
    var localRotationRadians: Double
    var localScale: Double

    init(
        id: UUID = UUID(),
        roomId: UUID,
        shapeType: ShapeType,
        sizeWidth: Double,
        sizeHeight: Double,
        localPositionX: Double,
        localPositionY: Double,
        localRotationRadians: Double = 0,
        localScale: Double = 1
    ) {
        self.id = id
        self.roomId = roomId
        self.shapeType = shapeType
        self.sizeWidth = sizeWidth
        self.sizeHeight = sizeHeight
        self.localPositionX = localPositionX
        self.localPositionY = localPositionY
        self.localRotationRadians = localRotationRadians
        self.localScale = localScale
    }
}
