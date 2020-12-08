//
//  WFHelpViewController.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 07/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit
import WebKit

class WFHelpViewController: UIViewController {
    
    @IBOutlet weak var helpWebview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = Strings.Help
        self.setwebview()

        self.setURL()
        // Do any additional setup after loading the view.
    }
    func setwebview()
    {
        self.helpWebview.scrollView.minimumZoomScale = 1.0
        self.helpWebview.scrollView.maximumZoomScale = 1.0
        self.helpWebview.scrollView.zoomScale = 1.0

    }
    func setURL()
    {
        do {
            guard let filePath = Bundle.main.path(forResource: "help", ofType: "html")
            else {
                print ("File reading error")
                return
            }
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            helpWebview.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
    }
}
