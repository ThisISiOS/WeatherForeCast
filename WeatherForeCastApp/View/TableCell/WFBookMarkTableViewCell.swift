//
//  WFBookMarkTableViewCell.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 06/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit

class WFBookMarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    var location : ForecastModel? {
        didSet {
            self.setupCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell()
    {
        self.locationLabel.text = self.location?.name
    }
}
