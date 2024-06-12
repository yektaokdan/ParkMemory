import Foundation
import CoreLocation

class LocationsViewModel {
    private var locations: [CLLocation] = []

    init() {
        loadLocations()
    }

    func loadLocations() {
        locations = UserDefaults.standard.loadLocations().reversed()
    }

    func numberOfLocations() -> Int {
        return locations.count
    }

    func location(at index: Int) -> CLLocation? {
        guard index >= 0 && index < locations.count else {
            return nil
        }
        return locations[index]
    }
    
    func deleteLocation(at index: Int) {
        guard index >= 0 && index < locations.count else {
            return
        }
        locations.remove(at: index)
        saveLocations()
    }
    
    private func saveLocations() {
        UserDefaults.standard.saveLocations(locations.reversed())
    }
}

