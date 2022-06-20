import Foundation

struct RestaurantPhoto: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case source
        
        case micro = "80x60"
        case tiny = "92x92"
        case mini = "160x120"
        case smaller = "184x184"
        case small = "240x135"
        case normal = "480x270"
        case big = "612x344"
        case bigger = "664x374"
        case huge = "1350x759"
    }
    
    let source: String
    
    let micro: String?
    let tiny: String?
    let mini: String?
    let smaller: String?
    let small: String?
    let normal: String?
    let big: String?
    let bigger: String?
    let huge: String?
}
