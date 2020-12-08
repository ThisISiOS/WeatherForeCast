//
//  HomeViewController.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 06/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit
import CoreLocation


class HomeViewController: UIViewController {

    @IBOutlet weak var bookmarkTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.HomeTitle
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setTableview()
        if bookMarkLocation.count == 0
        {
            self.bookmarkTable.isHidden = true
        }
        else
        {
            self.bookmarkTable.isHidden = false

            
        }
    }
    
    func setTableview()
    {
        self.bookmarkTable.register(CellNib.BookMarkCCell, forCellReuseIdentifier: CellIdentifier.BookMarkCCell)
        self.bookmarkTable.delegate = self
        self.bookmarkTable.dataSource = self
        self.bookmarkTable.estimatedRowHeight = 44.0
        self.bookmarkTable.rowHeight = UITableView.automaticDimension
        self.bookmarkTable.reloadData()
    }
    
    //MARK: Actions
    
    @IBAction func settingsAction(_ sender: Any)
    {
        self.navigationController?.pushViewController(Controller.Settings, animated: true)
    }
    @IBAction func HelpAction(_ sender: Any)
    {
        self.navigationController?.pushViewController(Controller.Help, animated: true)
    }
    @IBAction func openMap(_ sender: UIBarButtonItem) {
        let controller = Controller.Map
        controller.mapViewDelegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - function to go to city selection screen
    private func goToCityScreen(_ bookmarkForeCast: ForecastModel) {
        let controller = Controller.City
        controller.foreCastData = bookmarkForeCast
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController: MapViewDelegate {
    func onSelectedMapLocation(location: CLLocation) {
        print("delegate location", location)
        fetchCity(location: location) { (cityName) in
            print(cityName)
//            self.goToCityScreen(cityName: cityName)
        }
    }
    
    private func fetchCity(location: CLLocation, callback: @escaping (String) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            guard let placeMark = placemark?.first else {
                callback("")
                return
            }
            if let city = placeMark.subAdministrativeArea {
                callback(city)
            }
        }
    }
}
extension HomeViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarkLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.BookMarkCCell, for: indexPath) as? WFBookMarkTableViewCell
        {
            cell.location = bookMarkLocation[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookMarkLocation.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            WFAppManager.shared.setBookmarkUserDefault(bookmark: bookMarkLocation)

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToCityScreen(bookMarkLocation[indexPath.row])
    }
    
}

