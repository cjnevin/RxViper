import Foundation

protocol UserLocationDataStoreHaving {
    var userLocationDataStore: UserLocationDataStore { get }
}

protocol UserLocationDataStore {
    func userLocation(with id: Int) -> UserLocationDTO?
}

struct UserLocationMemoryDataStore: UserLocationDataStore {
    private let locations: [UserLocationDTO] = {
        return [
            UserLocationDTO(userId: 1, latitude: 49, longitude: -123.9),
            UserLocationDTO(userId: 2, latitude: 36, longitude: -119),
            UserLocationDTO(userId: 3, latitude: -37, longitude: 144),
            UserLocationDTO(userId: 4, latitude: 51, longitude: 0),
            UserLocationDTO(userId: 5, latitude: -26, longitude: 28)
        ]
    }()
    
    func userLocation(with id: Int) -> UserLocationDTO? {
        return locations.first(where: { $0.userId == id })
    }
}
