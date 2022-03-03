//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 28/02/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()) {
            print("location enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    //TODO: why called 4 times
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location = locations.last {
        print("locations", location)
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
      
        ServerCommunication.sharedInstance.fetchWeather(for: (latitude,longitude), onSuccess: onSuccess)
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError ", error) //TODO: show to the user
    }
    func onSuccess(result: Result<WeatherModel, NetworkError>) {
        
        DispatchQueue.main.async {
            switch result{
            case .success(let weather):
                self.weather.text = weather.weather[0].description
            case .failure(let error):
                print("on success error", error)
            }
        }
    }
    }

