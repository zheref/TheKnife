import Foundation

struct Restaurant: Codable {
    
    let name: String
    let uuid: String
    let priceRange: Int?
    let servesCuisine: String?
    let address: RestaurantAddress?
    
    let mainPhoto: RestaurantPhoto?
    
    let aggregateRatings: [String: RestaurantRating]?
    
    var isFavorite: Bool?
    
    var averageRating: Double? {
        guard let ratings = aggregateRatings, !ratings.isEmpty else {
            return nil
        }
        
        return ratings.compactMap({ $1.ratingValue }).reduce(.zero, +) / Double(ratings.count)
    }
    
    func withFavInfo(favorite: Bool?) -> Restaurant {
        Restaurant(name: self.name,
                   uuid: self.uuid,
                   priceRange: self.priceRange,
                   servesCuisine: self.servesCuisine,
                   address: self.address,
                   mainPhoto: self.mainPhoto,
                   aggregateRatings: self.aggregateRatings,
                   isFavorite: favorite)
    }
    
}
