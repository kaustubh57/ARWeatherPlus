//
//  ARWeatherViewSceneAdapterService.swift
//  ARWeatherPlus
//
//  Created by Kaustubh Kesarkar on 6/5/20.
//  Copyright © 2020 Kaustubh Kesarkar. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import RealityKit

class ARWeatherViewSceneAdapterService {
    
    var arView: ARView!
    
    let weatherSceneAnchor: Experience.WeatherScene!
    
    init() {
        let cameraAnchor: AnchorEntity = AnchorEntity(.camera)
        
        self.weatherSceneAnchor = try! Experience.loadWeatherScene()
        
        cameraAnchor.addChild(weatherSceneAnchor)
        
        weatherSceneAnchor.transform.translation = [0, -0.5, -0.8]
        
        arView = ARView(frame: .zero)
        arView.scene.addAnchor(cameraAnchor)
    }
    
    func cleanUpWeatherScene() {
        weatherSceneAnchor.notifications.hideSun.post()
        weatherSceneAnchor.notifications.hideMoon.post()
        weatherSceneAnchor.notifications.hideAllClouds.post()
    }
    
    func showWeatherScene(weatherVM: WeatherViewModel) -> Bool { weatherVM.cityName != "" }
    
    func updateCityName(cityName: String) {
        let cityNameEntity = (weatherSceneAnchor.cityName?.children[0].children[0])! as Entity
        var cityNameComponent: ModelComponent = (cityNameEntity.components[ModelComponent])!
        cityNameComponent.mesh = .generateText(
            "\(cityName)",
            extrusionDepth: 0.007,
            font: UIFont(name: "Arial", size: 0.03) ?? .systemFont(ofSize: 0.03),
            containerFrame: CGRect.init(x: 0.02, y: 0.0, width: 0, height: 0.0),
            alignment: .center,
            lineBreakMode: .byCharWrapping)
        cityNameEntity.components.set(cityNameComponent)
    }
    
    func updateTemperature(temperature: String) {
        let temperatureEntity = (weatherSceneAnchor.temperatureDisplay?.children[0].children[0].children[0])! as Entity
        var temperatureComponent: ModelComponent = (temperatureEntity.components[ModelComponent])!
        temperatureComponent.mesh = .generateText(
            "\(temperature)",
            extrusionDepth: 0.007,
            font: UIFont(name: "Arial", size: 0.025) ?? .systemFont(ofSize: 0.025),
            containerFrame: CGRect.init(x: 0.075, y: 0.0, width: 0, height: 0.0),
            alignment: .center,
            lineBreakMode: .byCharWrapping)
        temperatureEntity.components.set(temperatureComponent)
    }
    
    func updateWeatherScene(weatherVM: WeatherViewModel) {
        updateSun(weatherVM: weatherVM)
        updateMoon(weatherVM: weatherVM)
        updateClouds(weatherType: weatherVM.mainType)
    }
    
    func updateSun(weatherVM: WeatherViewModel) {
        if isDayTime(weatherVM: weatherVM) {
            weatherSceneAnchor.notifications.showSun.post()
        }
    }
    
    func updateMoon(weatherVM: WeatherViewModel) {
        if !isDayTime(weatherVM: weatherVM) {
            weatherSceneAnchor.notifications.showMoon.post()
        }
    }
    
    func updateClouds(weatherType: WeatherTypeEnum?) {
        
        switch weatherType {
        case .Clouds:
            weatherSceneAnchor.notifications.showClouds.post()
        case .Rain:
            weatherSceneAnchor.notifications.showRain.post()
        case .Thunderstorm:
            weatherSceneAnchor.notifications.showThunderstorms.post()
        case .none:
            weatherSceneAnchor.notifications.hideAllClouds.post()
        }
    }
    
    func isDayTime(weatherVM: WeatherViewModel) -> Bool {
        return ((weatherVM.timeOfData ?? 0 > weatherVM.sunriseTime ?? 0)
            && (weatherVM.timeOfData ?? 0 < weatherVM.sunsetTime ?? 0))
    }
    
}
