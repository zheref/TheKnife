import Foundation

class FavoritesDefaultsStore: FavoritesStoreProtocol {
    
    var defaults: UserDefaults? = {
        UserDefaults(suiteName: "dev.zheref.TheKnife.favorites")
    }()
    
    func push(for restaurantUUID: String, favorite: Bool) {
        print("Saving restaurant with \(restaurantUUID) as favorite \(favorite)")
        defaults?.set(favorite, forKey: restaurantUUID)
    }
    
    func pull(for restaurantUUID: String) -> Bool? {
        let isFavorite = defaults?.bool(forKey: restaurantUUID)
        print("Resolved restaurant with \(restaurantUUID) as favorite \(isFavorite)")
        return isFavorite
    }
    
}
