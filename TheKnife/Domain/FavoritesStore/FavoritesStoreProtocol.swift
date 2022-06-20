import Foundation

protocol FavoritesStoreProtocol: StoreProtocol {
    
    func push(for restaurantUUID: String, favorite: Bool)
    func pull(for restaurantUUID: String) -> Bool?
    
}
