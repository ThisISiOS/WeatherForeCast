//
//  WFForeCastCollectionCell.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 07/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit

class WFForeCastCollectionCell: UICollectionViewCell {

    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var humadityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(withForecast forecast: ForecastModel, withIndexPath indexPath: IndexPath, onController controller: UIViewController? = UIViewController()) {
        if let weatherMain = forecast.weather?[0]
        {
            self.mainLabel.text = ("\(weatherMain.main ?? ""): \(weatherMain.description ?? "")")
        }
        if let temp = forecast.main
        {
            let temperature = temp.temp
            var tempRange = ""
            var temperatureUnit = controller?.convertTemp(temp: temperature ?? 0.0, from: .kelvin, to: .celsius) // 18°C

            if (tempUnit == Strings.Imperial)
            {
                temperatureUnit = controller?.convertTemp(temp: temperature ?? 0.0, from: .kelvin, to: .fahrenheit) // 64°F
            }
            if let min = temp.temp_min , let max = temp.temp_max
            {
                tempRange = ("(\(min)-\(max))")
            }
            self.tempLabel.text = ("\(Strings.tempString) \(temperatureUnit ?? "N/A") \(tempRange)")
            self.humadityLabel.text = ("\(Strings.HumadityString): \(temp.humidity ?? 0.0)\(Strings.Humadity)")
        }
        if (forecast.wind) != nil
        {
            self.winLabel.text = ("\(Strings.WindString): \(forecast.wind?.speed ?? 0.0) \(Strings.WindUnit)")
        }
    }
}
