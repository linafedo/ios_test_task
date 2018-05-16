//
//  TableViewCell.swift
//  test task
//
//  Created by Galina Fedorova on 07/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var suitesAvailabilityLabel: UILabel!
    
    func configure(with item:HotelModel?) {
        if let hotelModel = item{
            nameLabel.text = hotelModel.name
            addressLabel.text = hotelModel.address
            starsLabel.text = String(hotelModel.stars)
            distanceLabel.text = String(hotelModel.distance)
            suitesAvailabilityLabel.text = hotelModel.suites_availabilityString.replacingOccurrences(of: ":", with: ",")
        }
    }
    
}
