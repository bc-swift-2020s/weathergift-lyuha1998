//
//  LOCATIONDETAILViewController.swift
//  weathergift
//
//  Created by Huiyi Victoria Lyu on 3/16/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    print("JUST CREATED A DATE FORMATTER")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
    
    
}()

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBOutlet weak var tableView: UITableView!
    
    var locationIndex = 0 
    var weatherDetail: WeatherDetail!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        updateUserInterface()
    }
    // for saving purposes
    
    func clearUserInterface() {

        dateLabel.text = ""
        placeLabel.text = ""
        temperatureLabel.text = ""
        summaryLabel.text = ""
        imageView.image = UIImage()
    }
    
    
    
    
    func updateUserInterface() {
        
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        let weatherLocation = pageViewController.weatherLocations[locationIndex]
         weatherDetail = WeatherDetail(name: weatherLocation.name, latitude: weatherLocation.latitude, longitude: weatherLocation.longitude)
        
        
        
        
        
      
        
        pageControl.numberOfPages = pageViewController.weatherLocations.count
        pageControl.currentPage = locationIndex
        weatherDetail.getData {
            
            DispatchQueue.main.async {
                dateFormatter.timeZone = TimeZone(identifier: self.weatherDetail.timezone)
                let usableDate = Date(timeIntervalSince1970: self.weatherDetail.currentTime)
                self.dateLabel.text = dateFormatter.string(from: usableDate)
                self.placeLabel.text = self.weatherDetail.name
                self.temperatureLabel.text = " \(self.weatherDetail.temperature)°"
                self.summaryLabel.text = self.weatherDetail.summary
                self.imageView.image = UIImage(named: self.weatherDetail.dailyIcon)
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
            
            
        }
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LocationListViewController
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        
        
        destination.weatherLocations = pageViewController.weatherLocations
        
        
    }
    @IBAction func unwindfromLocationListViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! LocationListViewController
        locationIndex =  source.selectedLocationIndex
         let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        
        pageViewController.weatherLocations = source.weatherLocations
        pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: locationIndex)], direction: .forward, animated: false, completion: nil)
        //source means the last page before the segway!!
    }
    @IBAction func pageControlTapped(_ sender: Any) {
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        
        
        var direction: UIPageViewController.NavigationDirection = .forward
        if (sender as AnyObject).currentPage < locationIndex {
            direction = .reverse
        }
        
    pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: (sender as AnyObject).currentPage)], direction: direction, animated: true, completion: nil)
        
        
        
    }
}
extension LocationDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetail.dailyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DailyTableViewCell
        cell.dailyWeather = weatherDetail.dailyWeatherData[indexPath.row]
        return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension LocationDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDetail.hourlyWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyCollectionViewCell
        hourlyCell.hourlyWeather = weatherDetail.hourlyWeatherData[indexPath.row]
        return hourlyCell
    }
    
    
}