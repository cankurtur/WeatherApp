//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Can Kurtur on 14.05.2021.
//

import UIKit

// This is the controller class which is the connection between the UI and the Data Model.
class WeatherViewController: UIViewController{
    
    var cityNames = [String]()
    var chosenCityNames = ""
    
    var temp = "nil"
    var city = "nil"
    var condition = "nil"
    
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        weatherManager.delegate = self
        
        // The elements/cells of the List are created manually. (Could be improved/extended in the future. This is kind of demo for now.)
        cityNames.append("Istanbul")
        cityNames.append("Riga")
        cityNames.append("London")
        cityNames.append("Paris")
        cityNames.append("Tokyo")
        cityNames.append("Stuttgart")
        cityNames.append("Copenhagen")
        cityNames.append("Berlin")
        cityNames.append("Warsaw")
        cityNames.append("Porto")
        cityNames.append("Venice")
        cityNames.append("Milan")
        cityNames.append("Madrid")
        cityNames.append("Bruges")
        cityNames.append("Amsterdam")
        cityNames.append("Kyiv")
        cityNames.append("Prague")
        cityNames.append("Vienna")
        cityNames.append("Budapest")
        
        navigationItem.title = "City List"
    }
    
    // This is the function for preparing the second screen before performing the segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSecond"{
            
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedImage = condition
            destinationVC.selectedCityName = city
            destinationVC.selectedTemp = temp
            
        }
    }
    
}

//MARK: - WeatherManagerDelegate

// With this extension, the data in the created model are assigned to the variables and updated.
extension WeatherViewController:WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        
        self.temp = weather.temperatureString
        self.city = weather.cityName
        self.condition = weather.conditionName
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - UITableViewDelegate,UITableViewDataSource

// In this extension, the table view list is created and controlled.
extension WeatherViewController:UITableViewDelegate,UITableViewDataSource{
    
    // This function is to remove the selected cells from the List.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            cityNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    // This sets the cells' height property up.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // This creates the whole cells, same amount of number with the "cityNames" array's length.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNames.count
    }
    
    // This fills the content of the created re-usable cell which is the type of "CustomTableViewCell".
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        // The shape of the cell is arranged to make its corners as circles
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.cityImage.layer.cornerRadius = cell.cityImage.frame.height / 2
        
        // Cell's image and its title is set according to the elements in the "cityNames" array and the images in the UIImage from Assets.
        cell.cityLabel?.text = cityNames[indexPath.row]
        cell.cityImage.image = UIImage(named: cityNames[indexPath.row])
        
        return cell
    }
    
    // On tapping the selected item from the List, the item's name is assigned to "chosenCityNames" variable to be used in "fetchWeather" function later on as a parameter so that when performing API request, that parameter is used in URL string dynamically. Since the data load from the request takes little bit time, ActivityIndicator is used here to indicate that some work is happening behind while waiting for the second screen's display with the related fetched data.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showSpinner()
        
        // Wait one second to simulate some work happening using "DispatchQueue.main.asyncAfter()". After 1 second delay, the "performSegue()" function is executed and when switching to second screen, the data is shown there without any problem.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // then remove the spinner view controller
            self.performSegue(withIdentifier: "goToSecond", sender: nil)
            self.removeSpinner()
        }
        chosenCityNames = cityNames[indexPath.row]
        weatherManager.fetchWeather(cityName: chosenCityNames)
        
    }
    
}
