//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Mark Parfenov on 08/03/2022.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayWeather(viewModel: Home.Home.ViewModelSuccess)
    func displayFailure(viewModel: Home.Home.ViewModelFailure)
}

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
