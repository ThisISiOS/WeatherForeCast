//
//  Weather.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 08/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation

struct CoordModel: Codable {
    var lon: Double?
    var lat: Double?
}

struct WeatherModel: Codable {
    var id: Int
    var main: String?
    var description: String?
    var icon: String?
}
struct MainModel: Codable {
    var temp: Float?
    var temp_min: Float?
    var temp_max: Float?
    var humidity: Float?
}
struct WindModel: Codable {
    var speed: Float?
    var deg: Float?
}

class  ForecastModel: Codable {
    var base: String?
    var id: Int?
    var visibility: Int?
    var coord: CoordModel?
    var weather: [WeatherModel]?
    var main: MainModel?
    var wind: WindModel?
    var name: String?

}

class  WeatherForeCast: Codable {
    var id: Int?
    var list: [ForecastModel]?
   
}
