import Foundation
import CoreLocation

struct UserLocationDTO {
    let userId: Int
    let latitude: Double
    let longitude: Double
    
    func asUserLocation() -> UserLocation {
        return UserLocation(
            userId: userId,
            latitude: latitude,
            longitude: longitude)
    }
}
