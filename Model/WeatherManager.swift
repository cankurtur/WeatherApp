//
//  CityManager.swift
//  WeatherApp
//
//  Created by Can Kurtur on 14.05.2021.
//

import Foundation
import CoreLocation

// The protocol named "WeatherManagerDelegate" has been defined here to call the functions in it to:
// 1)Update the weather,
// 2)Give an error in case of failure.
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) 
    func didFailWithError(error: Error)
}

// The WeatherManager struct is the place where all the API requests, fetching the data, parsing the JSON response operations are being done.
struct WeatherManager {
    
    // Here the apiKey (my own one for this project) is stated. It is received from the "https://openweathermap.org/".
    let apiKey = "baaaca2ce6ac086cf24f3f21060650c0"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    // Here with this function, the URL string of the request is defined dynamically according to the city name tapped from the list.
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&appid=\(apiKey)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    // Here the URL session is created. The response JSON data is received. The handling of any possible error is also being done in case the request fails.
    // The data received is parsed using the parseJSON function.
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
        
        
    }
    // The JSON data from the request, is adapted to weather data fields which has been defined before in "WeatherData.swift" file.
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            // The weather object is returned which is initialized with the fields comes above whose values are assigned with decoding JSON operation.
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}













