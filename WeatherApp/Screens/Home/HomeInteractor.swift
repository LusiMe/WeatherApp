//
//  HomeInteractor.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 08/03/2022.
//

import UIKit

protocol WeatherBusinessLogic {
    func weather(request: Home.Weather.Request)
}

// responcible for loading, deleting or saving data
//also different parts of logic can be handeled by diff workers
// eg NetworkWorker, CoreDataWorker...

class WeatherInteractor: WeatherBusinessLogic {
    var presenter: WeatherPresentationLogic?
    var worker: NetworkWeatherWorker?
    
    func weather(request: Home.Weather.Request) {
        let latitude = request.latitude
        let longitude = request.longitude
        //request
        worker?.fetchWeatherForCoordinates((latitude, longitude), onSuccess: onWeatherSuccess)
    }
    
    //move all details to the worker such as request, on success, parsing
    func onWeatherSuccess(result: Result<WeatherModel, NetworkError>) {
        let responce = Home.Weather.Responce(weatherData: result)
        //i could pass error here^ I need to think how to prevent it
        presenter?.presentWeather(response: responce)
        }
    }
//}
