//
//  first.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 21/03/2022.
//

import XCTest
@testable import WeatherApp

class first: XCTestCase {
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testValidApiCallGetsHTTPStatusCode200() throws {
        //given
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=37.33233141&lon=-122.0312186&appid=f21454c4f47c7d670854668f10e35e95"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Status code: 200")
        
        //when
        let dataTask = sut.dataTask(with: url) {_, response, error in
            //then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
    dataTask.resume()
    wait(for: [promise], timeout: 5)
}
    
    func testApiCallCompletes() throws {
        //given
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=37.33233141&lon=-122.0312186&appid=f21454c4f47c7d670854668f10e35e95"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        //when
        let dataTask = sut.dataTask(with: url) {_, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        //then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testRandomWeatherJsonData() throws {
//        given
        var result: Result<WeatherModel, NetworkError>?
        let weatherData = ["Weather" : "Good"]
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=37.33233141&lon=-122.0312186&appid=f21454c4f47c7d670854668f10e35e95"
        let url = URL(string: urlString)!
        let response = try JSONEncoder().encode(weatherData)
        
        let session =
    }
}
