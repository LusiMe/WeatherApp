//
//  HomeRouter.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 08/03/2022.
//

import Foundation

protocol RequestWeather {
    func fetchWeatherForCity(_ city: String, onSuccess: @escaping(Result<WeatherModel, NetworkError>) -> Void)
    
    func fetchWeatherForCoordinates(_ coordinates: (Double?, Double?), onSuccess: @escaping(Result<WeatherModel, NetworkError>) -> Void)
}

protocol GetCity {
    func findCity(with letters: String) -> [CityModel]?
}


class NetworkWeatherWorker {
    var interactor: WeatherInteractor?
    var dataAccess: ServerCommunication?
    
    private static let API_KEY = "f21454c4f47c7d670854668f10e35e95"
    
    private static let ROOT = "http://api.openweathermap.org/data/2.5/weather?"
    
    enum methods {
        static let get = "GET"
    }
    //TODO: move to services or smth
    private func requestBuilder(by coordinates: (Double?, Double?)? = (lat: nil, lon: nil), by cityName: String? = nil) -> URLRequest? {
        var urlBuilder = URLComponents(string: NetworkWeatherWorker.ROOT)
        if coordinates != nil {
        urlBuilder?.queryItems = [
            URLQueryItem(name: "lat", value: String(coordinates!.0!)),
            URLQueryItem(name: "lon", value:  String(coordinates!.1!)),
            URLQueryItem(name: "appid", value: NetworkWeatherWorker.API_KEY)
        ]
        }
        if cityName != nil {
            urlBuilder?.queryItems = [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: NetworkWeatherWorker.API_KEY)
            ]
        }
        guard let url = urlBuilder?.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = methods.get
        print("request", request)
        return request
    }
    
    private let weatherDecoder = ResultDecoder<WeatherModel>({ (data) throws -> WeatherModel in
        try JSONDecoder().decode(WeatherModel.self, from: data)
    })
    }

//maybe move to diff file
extension NetworkWeatherWorker: RequestWeather {
    
    func fetchWeatherForCity(_ city: String, onSuccess: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        if let request = requestBuilder(by: nil, by: city) {
            call(request: request, completion: onSuccess)
        }
    }
    
    func fetchWeatherForCoordinates(_ coordinates: (Double?, Double?), onSuccess: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        if let request = requestBuilder(by: coordinates) {
            call(request: request, completion: onSuccess)
        }
    }
    
    private func call(request: URLRequest, completion: @escaping(Result<WeatherModel, NetworkError>) -> Void) {
    URLSession.shared.dataTask(with: request) { result in
        completion(self.weatherDecoder.decode(result))
    }.resume()
}
    
}
