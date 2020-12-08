//
//  WFSettingsViewController.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 07/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit

class WFSettingsViewController: UIViewController {
    
    @IBOutlet weak var unitSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.SettingsTitle
        self.setSegment()
        // Do any additional setup after loading the view.
    }
    func setSegment()
    {
        if (tempUnit == Strings.Imperial)
        {
            self.unitSegment.selectedSegmentIndex = 1
        }
        
    }
    //MARK: Action
    
    @IBAction func tempUnitSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tempUnit = Strings.Metric
            WFAppManager.shared.setTempUnitUserDefault()
            break
        case 1:
            tempUnit = Strings.Imperial
            WFAppManager.shared.setTempUnitUserDefault()
            
            break
        default:
            break
        }
        
    }
    @IBAction func clearBookMark(_ sender: Any) {
        self.showAlert(title: Strings.AlertTitle, message: Strings.BookmarkDeleteAlert)
    }
    
}
extension WFSettingsViewController
{
    override func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.AlerYES, style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
            bookMarkLocation.removeAll()
            UserDefaults.standard.removeObject(forKey: Strings.Bookmark)
            UserDefaults.standard.synchronize()
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
       
    }
}
