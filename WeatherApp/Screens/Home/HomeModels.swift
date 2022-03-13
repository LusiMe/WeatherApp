//
//  HomeModels.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 08/03/2022.
//

import Foundation

enum Home {
    
    //MARK: Use cases
    enum Weather {
        struct Request {
            let latitude, longitude: Double
        }
        
        struct Responce {
            let weather, city: WeatherResult
        }
        
        struct ViewModelSuccess {
            let city, weather: String
        }
        
        struct ViewModelFailure{
            let errorMessage: String
        }
    }
}
