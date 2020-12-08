//
//  MapVViewController.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 06/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewDelegate {
    func onSelectedMapLocation(location: CLLocation)
}

class MapVViewController: UIViewController {
    let locationManager = CLLocationManager()
    var selectedLocation: CLLocation?
    var mapViewDelegate: MapViewDelegate?
    let annotation = MKPointAnnotation()

    @IBOutlet weak var mapBookmark: MKMapView!
    override func viewWillAppear(_ animated: Bool) {
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    override func viewDidLoad() {
        self.setpinToTap()
        self.title = Strings.MapTitle
    }
    func setpinToTap()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(gestureRecognizer:)))
            mapBookmark.addGestureRecognizer(gestureRecognizer)
    }
    //MARK: Actions
    
    @IBAction func doneButtonClick(_ sender: Any) {
        let geoCoder = CLGeocoder()
        var cityName = ""
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
                geoCoder.reverseGeocodeLocation(location, completionHandler:
                    {
                        placemarks, error -> Void in

                        // Place details
                        guard let placeMark = placemarks?.first else { return }
                        // City
                        if let city = placeMark.subAdministrativeArea {
                            print(city)
                            cityName = city
                        }
                        self.getCurrentForecast(self.annotation.coordinate.latitude, self.annotation.coordinate.longitude, cityName: cityName)

                })
        
        
        
    }
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: mapBookmark)
        let coordinate = mapBookmark.convert(location, toCoordinateFrom: mapBookmark)
        
        // Add annotation:
        annotation.coordinate = coordinate
        mapBookmark.addAnnotation(annotation)
    }
}

extension MapVViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location", locations.first)
            if let currentLocation = locations.first {
                selectedLocation = currentLocation
                if let mapViewDelegate = mapViewDelegate {
                    mapViewDelegate.onSelectedMapLocation(location: currentLocation)
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
