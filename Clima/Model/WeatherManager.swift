//
//  WeatherManager.swift
//  Clima
//
//  Created by Abhishek Bhardwaj on 13/04/23.

//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}
struct WeatherManager {
    let weatherURl =  "https://api.openweathermap.org/data/2.5/weather?appid=17ded01a7184a1d478f3ab422a647493&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURl)&q=\(cityName)"
//        print(urlString)
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        //1.Create a URL
        if let url = URL(string: urlString) {
            //2. Create A URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a Task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
                
            }
            //4.Start the task
            task.resume()
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            print(weather.conditionId)
            print(weather.temperatureString)
        }
        catch {
            print(error)
        }
        return nil
    }
}
