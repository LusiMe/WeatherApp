//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 08/03/2022.
//

import Foundation

protocol WeatherPresentationLogic {
    func presentWeather(response: Home.Weather.Responce)
}

class WeatherPresenter: WeatherPresentationLogic {
    weak var viewController: WeatherDisplayLogic?
    
    //MARK: Parse response from WeatherInteractor and send simple view model to WeatherViewController to be displayed
    // hide all details
    func presentWeather(response: Home.Weather.Responce) {
        DispatchQueue.main.async {
            switch response.weatherData {
            case .success(let weather):
                let weatherFullDescriprion = weather.weather[0].description
                let weatherShortDescription = weather.weather[0].main
                let city = weather.name
                let viewModelSuccess = Home.Weather.ViewModelSuccess(city: city, weatherFullDescriprion: weatherFullDescriprion, weatherShortDescription: weatherShortDescription)
                self.viewController?.displayWeather(viewModel: viewModelSuccess)
                
            case .failure(let networkError):
                switch networkError {
                case .transportError(let error):
                    let viewModelFailure = Home.Weather.ViewModelFailure(errorMessage: error.localizedDescription)
                    self.viewController?.displayFailure(viewModel: viewModelFailure)
                case .serverError(_):
                    let viewModelFailure = Home.Weather.ViewModelFailure(errorMessage: "\(networkError)")
                    self.viewController?.displayFailure(viewModel: viewModelFailure)
                case .decodingError(let error):
                    let viewModelFailure = Home.Weather.ViewModelFailure(errorMessage: " Decoding error: \(error.localizedDescription)")
                    self.viewController?.displayFailure(viewModel: viewModelFailure)
                case .encodingError(let error):
                    let viewModelFailure = Home.Weather.ViewModelFailure(errorMessage:  "Encoding error: \(error)")
                    self.viewController?.displayFailure(viewModel: viewModelFailure)
                default:
                    let viewModelFailure = Home.Weather.ViewModelFailure(errorMessage: networkError.localizedDescription)
                    self.viewController?.displayFailure(viewModel: viewModelFailure)
                }
        }
        
    }
}
}
