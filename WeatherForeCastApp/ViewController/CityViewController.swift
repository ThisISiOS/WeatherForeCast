//
//  CityViewController.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 06/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit


class CityViewController: UIViewController {
    var cityName: String?
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humadityLabel: UILabel!
    @IBOutlet weak var foreastCollection: UICollectionView!
    var foreCastData : ForecastModel?
    var lastFiveForecast : [ForecastModel] = []

    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var weatherMainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setData()
        self.getLastForecast(cityName: foreCastData?.name)
    }
    func setData()
    {
        if let weatherMain = self.foreCastData?.weather?[0]
        {
            self.weatherMainLabel.text = ("\(weatherMain.main ?? ""): \(weatherMain.description ?? "")")
        }
        if let temp = self.foreCastData?.main
        {
            let temperature = temp.temp
            var tempRange = ""
            var temperatureUnit = convertTemp(temp: temperature ?? 0.0, from: .kelvin, to: .celsius) // 18°C

            if (tempUnit == Strings.Imperial)
            {
                temperatureUnit = convertTemp(temp: temperature ?? 0.0, from: .kelvin, to: .fahrenheit) // 64°F
            }
            if let min = temp.temp_min , let max = temp.temp_max
            {
                tempRange = ("(\(min)-\(max))")
            }
            self.tempratureLabel.text = ("\(Strings.tempString) \(temperatureUnit) \(tempRange)")
            self.humadityLabel.text = ("\(Strings.HumadityString): \(temp.humidity ?? 0.0)\(Strings.Humadity)")
        }
        if (self.foreCastData?.wind) != nil
        {
            self.windLabel.text = ("\(Strings.WindString): \(self.foreCastData?.wind?.speed ?? 0.0) \(Strings.WindUnit)")
        }
    }
    func setCollectionview()
    {
        self.foreastCollection.register(CellNib.ForecastCell, forCellWithReuseIdentifier: CellIdentifier.ForecastCell)
        foreastCollection.delegate  = self
        foreastCollection.dataSource = self
        foreastCollection.reloadData()
    }
    
}
extension CityViewController
{
    func getLastForecast(cityName : String?) {
        let endPointUrl = "\(APIName.APIForeCast)q=\(cityName ?? "")&appid=\(Keys.APIKeys)"
        NetworkManager.shared.fetchResources(endPointUrl: endPointUrl) { (result: Result<WeatherForeCast, APIServiceError>) in
            print(result)
            switch result {
            case .success(let forecast):
                print(forecast)
                self.lastFiveForecast = forecast.list ?? [ForecastModel]()
                DispatchQueue.main.async {
                    self.setCollectionview()

                }

            case .failure(let error):
                print(error)
            }
        }
    }
}
extension CityViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.lastFiveForecast.count != 0
        {
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.ForecastCell, for: indexPath) as? WFForeCastCollectionCell
        {
            cell.setupCell(withForecast: self.lastFiveForecast[indexPath.row], withIndexPath: indexPath, onController: self)
            return cell

        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.foreastCollection.frame.size.width, height: 140)
    }
    
}
