//
//  ServerCommunication.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 01/03/2022.
//

import Foundation

class ServerCommunication {
    
    public static let sharedInstance = ServerCommunication()
    
    let API_KEY = "f21454c4f47c7d670854668f10e35e95"
    
    let ROOT = "http://api.openweathermap.org/data/2.5/weather?"
    
    enum methods {
        static let get = "GET"
    }
    
    private let weatherDecoder = ResultDecoder<WeatherModel>({ (data) throws -> WeatherModel in
        try JSONDecoder().decode(WeatherModel.self, from: data)
    })
    
    private func requestBuilder(by coordinates: (Double?, Double?)? = (lat: nil, lon: nil), by cityName: String? = nil) -> URLRequest? {
        var urlBuilder = URLComponents(string: ROOT)
        if coordinates != nil {
        urlBuilder?.queryItems = [
            URLQueryItem(name: "lat", value: String(coordinates!.0!)),
            URLQueryItem(name: "lon", value:  String(coordinates!.1!)),
            URLQueryItem(name: "appid", value: API_KEY)
        ]
        }
        if cityName != nil {
            urlBuilder?.queryItems = [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: API_KEY)
            ]
        }
        guard let url = urlBuilder?.url else {return nil}
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = methods.get
        return request
    }
    
    public func fetchWeather(for coordinates: (Double, Double), onSuccess: @escaping(Result<WeatherModel, NetworkError>) -> Void){
        if let request = requestBuilder(by: coordinates) {
            call(request: request, completion: onSuccess)
        }
    }
    
    public func fetchWeather(for city: String, onSuccess: @escaping(Result<WeatherModel, NetworkError>) -> Void) {
        if let request = requestBuilder(by: nil, by: city) {
            call(request: request, completion: onSuccess)
        }
    }
    
    private func call(request: URLRequest, completion: @escaping(Result<WeatherModel, NetworkError>) -> Void) {
    URLSession.shared.dataTask(with: request) { result in
        completion(self.weatherDecoder.decode(result))
    }.resume()
}
}

// разбить по файлам
//enum NetworkError: Error {
//    case transportError(Error)
//    case serverError(statusCode: Int)
//    case noData
//    case decodingError(Error)
//    case encodingError(Error)
//}
//
//extension NetworkError {
//    init?(data: Data?, response: URLResponse?, error: Error?) {
//        if let error = error {
//            self = .transportError(error)
//            return
//        }
//        
//        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//            self = .serverError(statusCode: response.statusCode)
//            return
//        }
//        
//        if data == nil {
//            self = .noData
//        }
//        return nil
//    }
//}
typealias WeatherResult = Result<Data, NetworkError>
typealias WeatherResponce = Result<WeatherModel, NetworkError>
//TODO: where to store?
//typealias WeatherResult = Result<WeatherModel, NetworkError>

//extension URLSession {
//    func dataTask(with request: URLRequest, resultHandler: @escaping(WeatherResult) -> Void) -> URLSessionDataTask {
//        return self.dataTask(with: request) { data, responce, error in
//            if let networkError = NetworkError(data: data, response: responce, error: error) {
//                resultHandler(.failure(networkError))
//                return
//            }
//            resultHandler(.success(data!))
//        }
//    }
//}
