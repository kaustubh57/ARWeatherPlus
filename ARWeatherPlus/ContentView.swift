//
//  ContentView.swift
//  SwiftUIExperiment
//
//  Created by Kaustubh Kesarkar on 6/1/20.
//  Copyright © 2020 Kaustubh Kesarkar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack{
                TextField("Enter city name", text: self.$weatherVM.cityName) {
                    self.weatherVM.search()
                }
                .frame(alignment: .center)
                .padding()
                .fixedSize()
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30, alignment: .center)
            
            ARMainView()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
