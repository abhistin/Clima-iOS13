//
//  WeatherData.swift
//  Clima
//
//  Created by Abhishek Bhardwaj on 24/04/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    var weather = [Weather]()
    var wind: Wind
}

struct Main: Decodable {
    let temp: Double
}
struct Weather: Decodable {
    let id: Int
}
struct Wind: Decodable{
    let speed: Double
    let deg: Int
}
