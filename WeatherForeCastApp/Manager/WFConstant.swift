//
//  DDConstant.swift
//  DoctorDirectory
//
//  Created by Hetal Patel on 03/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation
import UIKit


var bookMarkLocation : [ForecastModel] = []
var tempUnit : String = Strings.Metric
enum FieldTypes : String {
    case TextfieldType = "textfield"
    case DropdownType = "dropdown"
}
struct Storyboard {
    static let main = "Main"
}
struct Controller {
    static var City : CityViewController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "CityViewController") as? CityViewController)!
    }
    static var Map : MapVViewController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "MapVViewController") as? MapVViewController)!
    }
    static var Help : WFHelpViewController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "WFHelpViewController") as? WFHelpViewController)!
    }
    static var Settings : WFSettingsViewController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "WFSettingsViewController") as? WFSettingsViewController)!
    }
    
}
struct CellNib {
    static let BookMarkCCell       = UINib(nibName: CellIdentifier.BookMarkCCell, bundle: nil)
    static let ForecastCell        = UINib(nibName: CellIdentifier.ForecastCell, bundle: nil)
}

struct CellIdentifier {
    static let BookMarkCCell       = "WFBookMarkTableViewCell"
    static let ForecastCell        = "WFForeCastCollectionCell"
}
struct Strings {
    static let AlertOk = "Ok"
    static let AlertTitle = "WeatherForecast"
    static let FailureOperation = "Something went wrong. Please try again later"
    static let Done = "Done"
    static let AlerYES = "Yes"
    static let AlertCancel = "Cancel"
    static let Bookmark = "BookMark"
    static let WindUnit = "km/h"
    static let Humadity = "%"
    static let tempString = "Temperature"
    static let WindString = "Wind"
    static let HumadityString = "Humadity"
    static let Help = "Help"
    static let Metric = "Metric"
    static let Imperial = "Imperial"
    static let SettingsTitle = "Settings"
    static let BookmarkDeleteAlert = "Do you want to clear all the bookmarks?"
    static let DeleteMSG = "Your all bookmark locations are deleted successfully"
    static let MapTitle = "Map"
    static let HomeTitle = "Your Bookmarks"

}
struct APIName {
    static var APIWeather = NetworkManager.shared.baseURL + "weather?"
    static var APIForeCast = NetworkManager.shared.baseURL + "forecast?"

    
}
struct Keys {
    static let APIKeys = "fae7190d7e6433ec3a45285ffcf55c86"
    static let UnitKey = "TempUnit"
}

