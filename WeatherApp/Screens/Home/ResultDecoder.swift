//
//  ResultDecoder.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 16/03/2022.
//

import Foundation

struct ResultDecoder<T> {
    
    private let transform: (Data) throws -> T
    
    init (_ transform: @escaping (Data) throws -> T) {
        self.transform = transform
    }
    
    func decode(_ result: WeatherResult) -> Result<T, NetworkError> {
      result.flatMap { (data) -> Result<T, NetworkError> in
            Result { try transform(data) }.mapError { NetworkError.decodingError($0) }
        }
    }
}
