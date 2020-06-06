//
//  ARViewContainer.swift
//  ARWeatherPlus
//
//  Created by Kaustubh Kesarkar on 6/5/20.
//  Copyright © 2020 Kaustubh Kesarkar. All rights reserved.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit

struct ARMainView : View {
    
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}


struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    var arWeatherViewSceneAdapterService: ARWeatherViewSceneAdapterService = ARWeatherViewSceneAdapterService()
    
    func makeUIView(context: Context) -> ARView {
        return arWeatherViewSceneAdapterService.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        print("-- LOG2 -- updateUIView")
        
        arWeatherViewSceneAdapterService.cleanUpWeatherScene()
        
        if arWeatherViewSceneAdapterService.showWeatherScene(weatherVM: self.weatherVM) {
            arWeatherViewSceneAdapterService.updateCityName(cityName: self.weatherVM.cityName)
            arWeatherViewSceneAdapterService.updateTemperature(temperature: self.weatherVM.temperature)
            arWeatherViewSceneAdapterService.updateWeatherScene(weatherVM: self.weatherVM)
        }
    }
    
}

#if DEBUG
struct ARMainView_Previews : PreviewProvider {
    static var previews: some View {
        ARMainView()
    }
}
#endif

