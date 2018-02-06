import Foundation
import CoreLocation

struct UserLocation {
    let userId: Int
    let latitude: Double
    let longitude: Double
    
    var location: CLLocation {
        return CLLocation(latitude: latitude,
                          longitude: longitude)
    }
    
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
}
