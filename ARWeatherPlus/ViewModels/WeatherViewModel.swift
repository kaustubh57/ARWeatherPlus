//
//  WeatherViewModel.swift
//  ARWeatherPlus
//
//  Created by Kaustubh Kesarkar on 6/2/20.
//  Copyright © 2020 Kaustubh Kesarkar. All rights reserved.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    private var weatherService: WeatherService!
    
    @Published private var weatherData = WeatherData()
    
    init() {
        self.weatherService = WeatherService()
    }
    
    var temperature: String {
        
        if let temp = self.weatherData.main.temp {
            return String (format: "%.0f", temp)
        } else {
            return ""
        }
        
    }
    
    var humidity: String {
        
        if let humidity = self.weatherData.main.humidity {
            return String (format: "%.0f", humidity)
        } else {
            return ""
        }
        
    }
    
    var cityName: String = ""
    
    func search() {
        
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeather(by: city)
        }
        
    }
    
    private func fetchWeather(by city: String) {
        
        self.weatherService.getWeather(city: city) { weather in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.weatherData = weather
                }
                
            }
        }
    }
    
    var timeOfData: Int? {self.weatherData.dt}
    
    var sunriseTime: Int? {self.weatherData.sys.sunrise}
    
    var sunsetTime: Int? {self.weatherData.sys.sunset}
    
    var mainType: WeatherTypeEnum? {self.weatherData.weather[0].main}
    
}
