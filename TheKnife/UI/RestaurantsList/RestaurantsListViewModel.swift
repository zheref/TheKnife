import Foundation
import Bond

enum RestaurantSortOption {
    case name
    case rating
    case cuisine
}

class RestaurantsListViewModel {
    
    // MARK: - Operational
    let restaurantsStore: RestaurantsStoreProtocol
    let favoritesStore: FavoritesStoreProtocol
    
    // MARK: - Data Holding
    var restaurants = MutableObservableArray<Restaurant>()
    var errors = [Error]()
    
    init(restaurantsStore: RestaurantsStoreProtocol, favoritesStore: FavoritesStoreProtocol) {
        self.restaurantsStore = restaurantsStore
        self.favoritesStore = favoritesStore
    }
    
    // MARK: - Data Handling
    
    func prepare() {
        restaurantsStore.fetchAll { [weak self] restaurants, error in
            if let error = error {
                self?.errors.append(error)
                return
            }
            
            guard let restaurants = restaurants else { return }
            
            let combinedRestaurants = restaurants.map({
                $0.withFavInfo(favorite: self?.favoritesStore.pull(for: $0.uuid))
            })
            
            DispatchQueue.main.async { [weak self] in
                self?.restaurants.replace(with: combinedRestaurants)
            }
        }
    }
    
    func sort(by sortOption: RestaurantSortOption) {
        switch sortOption {
        case .name:
            restaurants.replace(with: restaurants.array.sorted(by: \.name, with: <))
        case .rating:
            restaurants.replace(with: restaurants.array.sorted(by: { $0.averageRating ?? 0 > $1.averageRating ?? 0 }))
        case .cuisine:
            restaurants.replace(with: restaurants.array.sorted(by: { $0.servesCuisine ?? "" < $1.servesCuisine ?? "" }))
        }
    }
    
    // MARK: - Data Processing
    
    static func readableRating(forRestaurant restaurant: Restaurant) -> String {
        guard let rating = restaurant.averageRating else {
            return ""
        }
        
        return String(format: "%.1f", rating)
    }
    
    static func readableAddress(_ address: RestaurantAddress) -> String {
        "\(address.street), \(address.locality ?? ""), \(address.postalCode ?? "")"
    }
    
}

extension RestaurantsListViewModel: FavoritesDelegate {
    func favorite(restaurantWithUUID uuid: String) {
        favoritesStore.push(for: uuid, favorite: true)
    }
    
    func unfavorite(restaurantWithUUID uuid: String) {
        favoritesStore.push(for: uuid, favorite: false)
    }
    
    func isFavorite(restaurantWithUUID uuid: String) -> Bool? {
        favoritesStore.pull(for: uuid)
    }
}
