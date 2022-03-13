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

class WeatherPresenter: WeatherPresentationLogic{
    weak var viewController: WeatherDisplayLogic?
    
    //MARK: Parse response from WeatherInteractor and send simple view model to WeatherViewController to be displayed
    
    func presentWeather(response: Home.Weather.Responce) {
        let weather = response.weather
        let city = response.city
        let viewModel = Home.Weather.ViewModelSuccess(city: city, weather: weather)
        viewController?.displayWeather(viewModel: viewModel)
    }
}
