//
//  WeatherService.swift
//  ARWeatherPlus
//
//  Created by Kaustubh Kesarkar on 6/2/20.
//  Copyright © 2020 Kaustubh Kesarkar. All rights reserved.
//

import Foundation

class WeatherService {
    
    let WEATHER_API_KEY: String = "{your api key}}"
    
    func getWeather(city: String, completion: @escaping (WeatherData?) -> ()) {
                
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(WEATHER_API_KEY)&units=imperial")
            else {
                completion(nil)
                return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
                        
            let weatherDataResponse = try? JSONDecoder().decode(WeatherData.self, from: data)
            if let weatherData = weatherDataResponse {
                completion(weatherData)
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
    
}
