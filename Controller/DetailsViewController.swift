//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Can Kurtur on 14.05.2021.
//

import UIKit

// This is the detail screen's swift file.
class DetailsViewController: UIViewController{
    
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!

    var selectedCityName = ""
    var selectedTemp = ""
    var selectedImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = selectedCityName
        temperatureLabel.text = "\(selectedTemp) °C"
        conditionImageView.image = UIImage(systemName: selectedImage)
        
    }

}
