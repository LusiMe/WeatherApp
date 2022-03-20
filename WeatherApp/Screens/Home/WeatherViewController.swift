
import UIKit
import CoreLocation

protocol WeatherDisplayLogic: class {
    func displayWeather(viewModel: Home.Weather.ViewModelSuccess)
    func displayFailure(viewModel: Home.Weather.ViewModelFailure)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {
    
    var interactor: WeatherInteractor?
    let locationManager = CLLocationManager()
    
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .fullScreen
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .fullScreen
        setup()
    }
    //MARK: - Setup Clean Code Design Pattern
    
    private func setup() {
        let viewController = self
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let worker = NetworkWeatherWorker()
        interactor.presenter = presenter
        interactor.worker = worker
        viewController.interactor = interactor
        presenter.viewController = viewController
        worker.interactor = interactor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
  //MARK: - display view model from HomePresenter
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    func displayWeather(viewModel: Home.Weather.ViewModelSuccess) {
        //display
        self.imageView.image = UIImage(named: viewModel.weatherShortDescription)
        self.locationLabel.text = viewModel.city
        self.weatherDescriptionLabel.text = viewModel.weatherFullDescriprion
    }
    
    func displayFailure(viewModel: Home.Weather.ViewModelFailure) {
        //display error
        self.locationLabel.isHidden = true
        self.weatherDescriptionLabel.text = viewModel.errorMessage
    }
    
    //to services
    func display() {
//        self.imageView.image = UIImage(data: <#T##CGImage#>)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            self.locationManager.stopUpdatingLocation()
        if let location = locations.last {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let request = Home.Weather.Request(latitude: latitude, longitude: longitude)
            self.interactor?.weather(request: request)
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError ", error) //TODO: show to the user
    }
}
