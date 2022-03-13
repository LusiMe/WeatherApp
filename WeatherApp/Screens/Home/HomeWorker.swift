//
//  HomeRouter.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 08/03/2022.
//

import Foundation

protocol RequestWeather {
   func fetchWeather(completionHandler:((Result<WeatherModel, NetworkError>) -> Void))
}

protocol GetCity {
    func findCity(with letters: String) -> [CityModel]?
}

class WeatherWorker: RequestWeather {
    var interactor: WeatherInteractor?
    var dataAccess: ServerCommunication?
    //implement data request for serverCommunicationStore
    
    func fetchWeather(completionHandler: ((Result<WeatherModel, NetworkError>) -> Void)) {
        
    }
}
