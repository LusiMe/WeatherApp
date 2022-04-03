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


//struct ResultDecoder<T> {
//
//    private let transform: (Data) throws -> T
//
//    init (_ transform: @escaping (Data) throws -> T) {
//        self.transform = transform
//    }
//
//    func decode(_ result: WeatherResult) -> Result<T, NetworkError> {
//      result.flatMap { (data) -> Result<T, NetworkError> in
//            Result { try transform(data) }.mapError { NetworkError.decodingError($0) }
//        }
//
//    }
//}
