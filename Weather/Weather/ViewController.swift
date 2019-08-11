//
//  ViewController.swift
//  Weather
//
//  Created by Anton Martsenyuk on 7/24/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentView = 0 {
        didSet {
            updateInfo()
        }
    }
    
    let city = ["Kiev", "Moscow", "London"]
    let titleLabel = ["Temperature", "Pressure", "Humidity", "Speed", "Degrees"]
    var weather = [String:String]()
    
    @IBOutlet weak var citySegmentedControl: UISegmentedControl! 
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func switchView(_ citySegmentedControl: UISegmentedControl) {
        currentView = citySegmentedControl.selectedSegmentIndex
    }

    func updateInfo() {
        _ = WeatherGetter().getWeather(city: city[currentView]) { data in
            self.weather = data.allInfo
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        for i in 0..<3 {
            citySegmentedControl.setTitle(city[i], forSegmentAt: i)
        }
        updateInfo()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return city[currentView]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        cell.descriptionLabel.text = titleLabel[indexPath.row]
        cell.indicatorsLabel.text = weather[titleLabel[indexPath.row]]
        return cell
    }
}



