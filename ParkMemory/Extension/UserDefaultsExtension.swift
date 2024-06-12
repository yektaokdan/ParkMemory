import Foundation
import CoreLocation

extension UserDefaults {
    private enum Keys {
        static let savedLocations = "savedLocations"
    }
    
    func saveLocations(_ locations: [CLLocation]) {
        let locationData = locations.map { location -> [String: Double] in
            return ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude]
        }
        UserDefaults.standard.set(locationData, forKey: Keys.savedLocations)
    }
    
    func loadLocations() -> [CLLocation] {
        guard let locationData = UserDefaults.standard.array(forKey: Keys.savedLocations) as? [[String: Double]] else {
            return []
        }
        return locationData.map { data -> CLLocation in
            let latitude = data["latitude"] ?? 0.0
            let longitude = data["longitude"] ?? 0.0
            return CLLocation(latitude: latitude, longitude: longitude)
        }
    }
}
