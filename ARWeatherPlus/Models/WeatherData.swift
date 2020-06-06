//
//  WeatherData.swift
//  ARWeatherPlus
//
//  Created by Kaustubh Kesarkar on 6/2/20.
//  Copyright © 2020 Kaustubh Kesarkar. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    init() {
        dt = 0
        main = Temperature()
        sys = SunriseSunsetTime()
        weather = [WeatherType()]
    }
    
    let dt: Int
    let main: Temperature
    let sys: SunriseSunsetTime
    let weather: [WeatherType]

}

struct Temperature: Decodable {
    
    var temp: Double?
    var humidity: Double?
    var timeOfData: Int?
    var mainType: String?
    
}

struct SunriseSunsetTime: Decodable {
    
    var sunrise: Int?
    var sunset: Int?
    
}

struct WeatherType: Decodable {
    
    var main: WeatherTypeEnum?
    
}

enum WeatherTypeEnum: String, Decodable {

    case Clouds
    case Rain
    case Thunderstorm

}
