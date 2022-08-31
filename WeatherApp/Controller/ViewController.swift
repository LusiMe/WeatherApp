
import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    var searchResult = [CityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()) {
            print("location enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func onWeatherSuccess(result: Result<WeatherModel, NetworkError>) {
        DispatchQueue.main.async {
            switch result{
            case .success(let weather):
                self.weather.text = weather.weather[0].description
                self.locationLabel.text = weather.name
                self.weatherIcon.image = UIImage(named: weather.weather[0].main)
            case .failure(let error):
                self.weather.text = Utils.shared.specifyError(error)
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    //TODO: why called 4 times
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            self.locationManager.stopUpdatingLocation()
        if let location = locations.last {
        print("locations", location)
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        ServerCommunication.sharedInstance.fetchWeather(for: (latitude,longitude), onSuccess: onWeatherSuccess)
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError ", error)
        self.weather.text = "location manager failed with error /(error)"
    }
 
    }

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchBar.text != nil else {return}
        if searchBar.text!.count > 2 {
            findCity(by: searchBar.text!)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else {return}
        findCity(by: searchBar.text!)
    }
    
    //TODO: maybe move to worker?
    func findCity(by searchText: String) {
        guard Worker.sharedInstance.findCity(by: searchText) != nil else {return}
         searchResult = Array(Set(Worker.sharedInstance.findCity(by: searchText)!))
        tableView.isHidden = false
        tableView.reloadData()
    }
}

