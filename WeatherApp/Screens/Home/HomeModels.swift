//
//  HomeModels.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 08/03/2022.
//

import Foundation

enum Home {
    
    //MARK: Use cases
    enum Home {
        struct Request {
            let latitude, longitude: Double
        }
        
        struct Responce {
            let weather: WeatherResult
        }
        
        struct ViewModelSuccess {
            
        }
    }
}
