//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Can Kurtur on 16.05.2021.
//

import UIKit

// This the swift file which is the place for defining the objects which is in the "customCell" that has been created before.
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
}
