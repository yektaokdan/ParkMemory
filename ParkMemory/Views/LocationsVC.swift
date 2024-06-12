import UIKit
import CoreLocation

class LocationsVC: UIViewController {
    private var viewModel: LocationsViewModel!
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        viewModel = LocationsViewModel()
        setupTableView()
        setupNotificationCenter()
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
        view.addSubview(tableView)
    }

    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidSaveLocation), name: .didSaveLocation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidDeleteLocation), name: .didDeleteLocation, object: nil)
    }

    @objc private func handleDidSaveLocation() {
        viewModel.loadLocations() 
        tableView.reloadData()
    }

    @objc private func handleDidDeleteLocation() {
        viewModel.loadLocations()
        tableView.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LocationsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        if let location = viewModel.location(at: indexPath.row) {
            cell.textLabel?.text = "Lat: \(location.coordinate.latitude), Lon: \(location.coordinate.longitude)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteLocation(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            NotificationCenter.default.post(name: .didDeleteLocation, object: nil)
        }
    }

}
