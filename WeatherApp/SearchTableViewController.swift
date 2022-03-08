//
//  SearchTable.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 06/03/2022.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        cell.cityName.text = searchResult[indexPath.row].name + ", " + searchResult[indexPath.row].country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName = searchResult[indexPath.row].name
       ServerCommunication.sharedInstance.fetchWeather(for: cityName, onSuccess: onWeatherSuccess)
        tableView.isHidden = true
    }
}
