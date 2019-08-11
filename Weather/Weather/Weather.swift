//
//  Weather.swift
//  Weather
//
//  Created by Anton Martsenyuk on 7/25/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import Foundation
struct Weather: Decodable {
    
    let main: Main
    let wind: Wind
    
    struct Main: Decodable {
        let temp: Double
        let pressure: Int
        let humidity: Double
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Double
    }
    
    var allInfo: [String: String]{
        get {
            let celsius = main.temp - 273.15
            return ["Temperature": String(celsius.rounded())+" °C", "Pressure": String(main.pressure)+" hPa", "Humidity": String(main.humidity)+" %", "Speed": String(wind.speed)+" meter/sec", "Degrees": String(wind.deg)+" °"]
        }
    }
}
