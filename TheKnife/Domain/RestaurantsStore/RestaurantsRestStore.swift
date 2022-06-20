import Foundation

class RestaurantsRestStore: RestaurantsStoreProtocol {
    
    func fetchAll(_ resolve: @escaping RestaurantsResolver) {
        let task = URLSession.shared.dataTask(with: baseApiUrl) { [weak self] data, response, error in
            if let error = error {
                resolve(nil, error)
                return
            }
            
            guard let data = data else {
                resolve(nil, StoreError.nullData)
                return
            }
            
            guard let restaurants = self?.decode(data: data) else {
                resolve(nil, StoreError.unableToSerialize)
                return
            }
            
            resolve(restaurants, nil)
        }
        
        task.resume()
    }
    
}
