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
class WeatherInteractor: WeatherBusinessLogic {
    var presenter: WeatherPresentationLogic?
    var worker: WeatherWorker?
    
    func weather(request: Home.Weather.Request) {
        //
    }
    
    
}
