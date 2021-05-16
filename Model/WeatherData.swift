//
//  CityData.swift
//  WeatherApp
//
//  Created by Can Kurtur on 14.05.2021.
//

//This swift file is created to define properties which we use in our app that corresponds the properties from WeatherManager JSON response after the request applied.
import Foundation


struct WeatherData:Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main:Codable {
    let temp : Double
}

struct Weather:Codable {
    let description:String
    let id: Int
}
