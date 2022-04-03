//
//  HomeModels.swift
//  WeatherApp
//
//  Created by Luda Parfenova on 08/03/2022.
//

import Foundation

enum Home {
    
    //MARK: Use cases
    enum Weather {
        struct Request {
            let latitude, longitude: Double
        }
        
        struct Responce {
            let weatherData: WeatherResponce
        }
        
        struct ViewModelSuccess {
            let city, weatherFullDescriprion, weatherShortDescription: String
        }
        
        struct ViewModelFailure{
            let errorMessage: String
        }
    }
}
