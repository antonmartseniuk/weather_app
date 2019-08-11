//
//  WeatherGetter.swift
//  Weather
//
//  Created by Anton Martsenyuk on 7/24/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import Foundation

class WeatherGetter {
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapApiKey = "9545b167033875ce7076d061841d6ed5"
    
    
    func getWeather(city: String, completionBlock: @escaping (Weather) -> Void) {
        let session = URLSession.shared
        
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?q=\(city)&appid=\(openWeatherMapApiKey)")!
        
        let dataTask = session.dataTask(with: weatherRequestURL) { (data, response, error) in
            guard let dataResponse = data, error == nil else {return}
            do{
                let jsonResponse = try JSONDecoder().decode(Weather.self, from: dataResponse)
                completionBlock(jsonResponse)
            } catch let parsingError {
                print("Error: \(parsingError)")
                
            }
            
        }
        dataTask.resume()
    }
}
