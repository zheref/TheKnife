import Foundation

struct RestaurantAddress: Codable {
    let street: String
    let postalCode: String?
    let locality: String?
    let country: String?
}
