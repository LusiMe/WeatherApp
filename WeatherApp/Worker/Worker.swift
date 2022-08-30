import Foundation

class Worker {
    static let sharedInstance = Worker()
    
    //Parse local city json
    private func readCityFile() -> Data? {
        do {
            if let path = Bundle.main.path(forResource: "cities", ofType: "json"),
               let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
                    return jsonData
                }
            } catch {
                print(error)
            }
            return nil
        }
    
    private func parse(jsonData: Data) -> [CityModel]? {
        do {
            let decodedData = try JSONDecoder().decode([CityModel].self, from: jsonData)
//            print(decodedData) // is printing
            return decodedData
        } catch {
            print("decode error", error)
        }
        return nil
    }
    
    private func parsedCityList() -> [CityModel]? {
        if let cityList = readCityFile() {
            if let parsedData = parse(jsonData: cityList) {
                return parsedData
            }
        }
        return nil
    }
    
    //find cities by search request
    
    public func findCity(by name: String) -> [CityModel]? {
        if let cityList = parsedCityList() {
            let suggestedCities = cityList.filter{$0.name.contains(name)}
            return suggestedCities
        }
        return nil
    }
    
    }

