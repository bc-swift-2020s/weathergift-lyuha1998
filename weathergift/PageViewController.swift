//
//  PageViewController.swift
//  weathergift
//
//  Created by Huiyi Victoria Lyu on 3/17/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    var weatherLocations: [WeatherLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.delegate = self
        self.dataSource = self
        loadLocations()
    setViewControllers([createLocationDetailViewController(forPage: 0)], direction: .forward, animated: false, completion: nil)
        
        
        
        
    }
    
    func loadLocations() {
           guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations") as? Data else {
               print("Error!Warning")
            weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 20.20, longitude: 20.20))
               return
           }
           let decoder = JSONDecoder()
           if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation] {
               self.weatherLocations = weatherLocations
           } else {
               print("could not decode data")
           }
        
        if weatherLocations.isEmpty {
            weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 20.20, longitude: 20.20))
        }
       }
    
    
    
    
    
    func createLocationDetailViewController (forPage page: Int) -> LocationDetailViewController {
        let detailViewController = storyboard!.instantiateViewController(identifier: "LocationDetailViewController") as! LocationDetailViewController
        
        detailViewController.locationIndex = page
        return detailViewController
        
    }
    
}

//swipe before and after!!!!

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as?  LocationDetailViewController {
            if currentViewController.locationIndex > 0 {
                return createLocationDetailViewController(forPage: currentViewController.locationIndex-1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as?  LocationDetailViewController {
            if currentViewController.locationIndex < weatherLocations.count-1 {
                return createLocationDetailViewController(forPage: currentViewController.locationIndex + 1)
            }
        }
        return nil
        
        
}
}
