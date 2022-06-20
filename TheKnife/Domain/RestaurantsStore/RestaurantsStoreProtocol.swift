import Foundation

typealias RestaurantsResolver = ([Restaurant]?, Error?) -> Void

private struct ResponseBodyRoot: Codable {
    let data: [Restaurant]
}

protocol RestaurantsStoreProtocol: StoreProtocol {
    
    func fetchAll(_ resolver: @escaping RestaurantsResolver)
    
    func decode(data: Data) -> [Restaurant]?
    
}

extension RestaurantsStoreProtocol {
    
    func decode(data: Data) -> [Restaurant]? {
        let decoded = try? JSONDecoder().decode(ResponseBodyRoot.self, from: data)
        return decoded?.data
    }
    
}
