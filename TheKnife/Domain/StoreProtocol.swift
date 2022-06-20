import Foundation

enum StoreError: Error {
    case nullData
    case unableToSerialize
}

protocol StoreProtocol {
    var baseApiUrl: URL! { get }
}

extension StoreProtocol {
    
    var baseApiUrl: URL! {
        let baseUrlString = Bundle.main.infoDictionary?["kBaseApiUrl"] as! String
        return URL(string: baseUrlString)
    }
    
}
