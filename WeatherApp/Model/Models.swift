//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Luda Parfenova on 01/03/2022.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let weather: [Weather]
}
struct Weather: Codable {
    let main, description: String
}

struct CityModel: Codable, Hashable {
    let name, country: String
}

