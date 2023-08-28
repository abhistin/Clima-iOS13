//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate   {
    var weathermanager = WeatherManager()
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        weathermanager.delegate = self
        searchtextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
//        print(searchtextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchtextField.endEditing(true)
        print(searchtextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchtextField.text {
            weathermanager.fetchWeather(cityName: city)
        }
        searchtextField.text = ""
    }
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
    }
    
}

