import UIKit
import MapKit

class MapViewVC: UIViewController, MKMapViewDelegate {
    let callToActionButton = PMCustomButton(backgroundColor: UIColor.label.withAlphaComponent(0.9), title: "Save My Location")
    private var mapView: MKMapView!
    private var viewModel: MapVM
    private var shouldUpdateLocation = true
    private var locationUpdateTimer: Timer?
    
    init(viewModel: MapVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        bindViewModel()
        configureCallToActionButton()
        addPinsToMap() // Kaydedilen pinleri yükle
        setupNotificationCenter()
    }
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidDeleteLocation), name: .didDeleteLocation, object: nil)
    }

    @objc private func handleDidDeleteLocation() {
        addPinsToMap()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
    }
    
    private func bindViewModel() {
        viewModel.locationUpdateHandler = { [weak self] location in
            guard let self = self else { return }
            if self.shouldUpdateLocation {
                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func configureCallToActionButton() {
        self.view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        callToActionButton.setTitleColor(.systemBrown, for: .normal)
        
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let offset: CGFloat = -50
        
        NSLayoutConstraint.activate([
            callToActionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            callToActionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -(tabBarHeight + offset)),
            callToActionButton.widthAnchor.constraint(equalToConstant: 220),
            callToActionButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func saveButtonTapped() {
        viewModel.saveCurrentLocation()
        addPinsToMap()
        NotificationCenter.default.post(name: .didSaveLocation, object: nil)
    }
    
    private func addPinsToMap() {
        mapView.removeAnnotations(mapView.annotations)
        for location in viewModel.savedLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = "Saved Location"
            mapView.addAnnotation(annotation)
        }
    }

    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else { return }
        openMapsAppWithDirections(to: coordinate)
    }
    
    private func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D) {
        let destinationPlacemark = MKPlacemark(coordinate: coordinate)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        destinationItem.name = "Saved Location"
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        destinationItem.openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        shouldUpdateLocation = false
        locationUpdateTimer?.invalidate()
        locationUpdateTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(enableLocationUpdates), userInfo: nil, repeats: false)
    }
    
    @objc private func enableLocationUpdates() {
        shouldUpdateLocation = true
    }
}
