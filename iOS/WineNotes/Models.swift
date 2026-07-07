import Foundation

struct Wine: Identifiable, Codable, Equatable {
    let id: UUID
    var wine: String
    var region: String
    var vintage: Int
    var rating: Int
    var createdAt: Date

    init(id: UUID = UUID(), wine: String = "", region: String = "", vintage: Int = 0, rating: Int = 0, createdAt: Date = Date()) {
        self.id = id
        self.wine = wine
        self.region = region
        self.vintage = vintage
        self.rating = rating
        self.createdAt = createdAt
    }
}
