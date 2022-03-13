
import UIKit

protocol WeatherDisplayLogic: class {
    func displayWeather(viewModel: Home.Weather.ViewModelSuccess)
    func displayFailure(viewModel: Home.Weather.ViewModelFailure)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {
    
    var interactor: WeatherBusinessLogic?
    
    //MARK: - Setup Clean Code Design Pattern
    
    private func setup() {
        let viewController = self
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let worker = WeatherWorker()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        worker.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  //MARK: - display view model from HomePresenter
    func displayWeather(viewModel: Home.Weather.ViewModelSuccess) {
        //display
    }
    
    func displayFailure(viewModel: Home.Weather.ViewModelFailure) {
        //display error
    }
    
}
