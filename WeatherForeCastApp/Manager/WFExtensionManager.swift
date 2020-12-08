//
//  GlobalManager.swift
//  Global
//
//  Created by Hetal Patel on 04/12/20.
//

import UIKit

typealias ActionHandlerButton = ((UIButton) -> ())

//MARK:- Declare Extension
extension UIViewController
{
    
  @objc  func showAlert(title : String , message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.AlertOk, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func convertTemp(temp: Float, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: Double(temp), unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }
    func getCurrentForecast(_ lat : Double , _ long : Double,cityName : String?) {
        let endPointUrl = "\(APIName.APIWeather)lat=\(lat)&lon=\(long)&appid=\(Keys.APIKeys)"
        NetworkManager.shared.fetchResources(endPointUrl: endPointUrl) { (result: Result<ForecastModel, APIServiceError>) in
            print(result)
            
            switch result {
            case .success(let forecastData):
                print(forecastData)
                if cityName?.trim.count != 0
                {
                    forecastData.name = cityName
                    
                }
                bookMarkLocation.append(forecastData)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
                WFAppManager.shared.setBookmarkUserDefault(bookmark: bookMarkLocation)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension String {
    //MARK:-
    
    var trim : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var IsEmpty : Bool {
        return (self.count <= 0)
    }
    
    /*var isValidEmail : Bool {
     let predicate = NSPredicate(format:"SELF MATCHES %@", RegexEmail)
     let isValid = predicate.evaluate(with: self)
     return isValid
     }
     
     var isValidPhone : Bool {
     let predicate = NSPredicate(format:"SELF MATCHES %@", RegexPhone)
     let isValid = predicate.evaluate(with: self)
     return isValid
     }*/ //Uncomment if you want the statis validation for email and phone
    
    var containSpecialCharacter : Bool {
        let regex = try? NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        let match = regex?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, self.count))
        let exist = (match != nil)
        return exist
    }
    
    //MARK:-
    
    func lengthMax(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthMin(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthEqual(Length length:Int) -> Bool {
        let isValid = (self.count == length)
        return isValid
    }
    
    func hintAttributeString(Attributes dictAttribute: [NSAttributedString.Key : Any]? = nil) -> NSMutableAttributedString? {
        let dictAttribute = [NSAttributedString.Key.foregroundColor:UIColor.darkGray,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0) ]
        var attrStr = NSMutableAttributedString.init(string: self, attributes: dictAttribute)
        
        attrStr =  NSMutableAttributedString.init(string: self)
        let range = NSMakeRange(0, (attrStr.string.count))
        attrStr.addAttributes(dictAttribute, range: range)
        attrStr.addAttributes(dictAttribute, range: ((attrStr.string as NSString?)?.range(of: attrStr.string))!)
        
        return attrStr
        
    }
}
