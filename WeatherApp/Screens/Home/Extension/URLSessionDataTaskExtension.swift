//
//  URLSessionDataTaskExtension.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 16/03/2022.
//

import Foundation

extension URLSession {
    func dataTask(with request: URLRequest, resultHandler: @escaping(WeatherResult) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, responce, error in
            if let networkError = NetworkError(data: data, response: responce, error: error) {
                resultHandler(.failure(networkError))
                return
            }
            resultHandler(.success(data!))
        }
    }
}
