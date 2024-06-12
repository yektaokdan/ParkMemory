import Foundation
import CoreLocation

class MapVM: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager
    var locationUpdateHandler: ((CLLocation) -> Void)?
    var currentLocation: CLLocation?
    var savedLocations: [CLLocation] = [] {
        didSet {
            UserDefaults.standard.saveLocations(savedLocations)
        }
    }
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        savedLocations = UserDefaults.standard.loadLocations()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            locationUpdateHandler?(location)
        }
    }
    
    func saveCurrentLocation() {
        if let location = currentLocation {
            savedLocations.append(location)
        }
    }
    
}
