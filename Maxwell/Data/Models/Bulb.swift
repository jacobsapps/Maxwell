import Foundation
import SQLiteData

@Table("bulbs")
struct Bulb: Codable, Identifiable, Sendable {
    var id: UUID
    var roomId: UUID
    var name: String
    var bulbTypeId: String
    var isWorking: Bool
    var markedNotWorkingAt: Date?

    init(
        id: UUID = UUID(),
        roomId: UUID,
        name: String,
        bulbTypeId: String,
        isWorking: Bool = true,
        markedNotWorkingAt: Date? = nil
    ) {
        self.id = id
        self.roomId = roomId
        self.name = name
        self.bulbTypeId = bulbTypeId
        self.isWorking = isWorking
        self.markedNotWorkingAt = markedNotWorkingAt
    }
}
