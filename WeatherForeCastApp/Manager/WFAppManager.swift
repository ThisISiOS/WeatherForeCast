//
//
//  Created by Hetal Patel on 03/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation
class WFAppManager : NSObject {
    enum AppStatusType : Int {
        case production
        case staging
        case local
    }
    
    static let shared = WFAppManager()
    var appStatus : AppStatusType = .local
    
    func setBookmarkUserDefault(bookmark:[ForecastModel])
    {
        let userDefaults = UserDefaults.standard
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(bookmark) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: Strings.Bookmark)
            userDefaults.synchronize()
            
        }
    }
    func getBookmarkUserDefault()
    {
        let defaults = UserDefaults.standard
        if  let data = defaults.data(forKey: Strings.Bookmark)
        {
            let decoder = JSONDecoder()
            if let encoded = try? decoder.decode([ForecastModel].self, from: data) {
                bookMarkLocation = encoded
            }
        }
    }
    func setTempUnitUserDefault()
    {
        let defaults = UserDefaults.standard
        defaults.setValue(tempUnit, forKey: Keys.UnitKey)
        defaults.synchronize()
        
    }
    
    func getTempUnit()
    {
        let defaults = UserDefaults.standard
        if let unit = defaults.value(forKey: Keys.UnitKey)
        {
            tempUnit = unit as! String
        }
        
    }
}
