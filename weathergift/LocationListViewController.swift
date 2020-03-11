//
//  ViewController.swift
//  weathergift
//
//  Created by Huiyi Victoria Lyu on 3/9/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editBarButton: UIToolbar!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var weatherLocations: [WeatherLocation] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var weatherLocation = WeatherLocation(name: "Chestnut Hill,MA", latitude: 0, longitude: 0)
        weatherLocations.append(weatherLocation)
        
        weatherLocation = WeatherLocation(name: "Lilongwe, Malawi", latitude: 0, longitude: 0)
        weatherLocations.append(weatherLocation)
        
        weatherLocation = WeatherLocation(name: "Buenos Aires,Argentina", latitude: 0, longitude: 0)
        weatherLocations.append(weatherLocation)
        
        tableView.dataSource =  self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }


    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func EditButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
                   tableView.setEditing(false, animated: true)
                   sender.title = "Edit"
                   addBarButton.isEnabled = true
               } else {
                   tableView.setEditing(true, animated: true)
                   sender.title = "Done"
                   addBarButton.isEnabled = false
               }
           }
        
    }
    


extension LocationListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = weatherLocations[indexPath.row].name
        return cell
        //what is going to be inside of the cell, find out from the struct!!!
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               weatherLocations.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
            
           }
       }
       
       func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
           let itemToMove = weatherLocations[sourceIndexPath.row]
           weatherLocations.remove(at: sourceIndexPath.row)
           weatherLocations.insert(itemToMove, at: destinationIndexPath.row)
       
       }
    
}
//reusable codes for removing, moving the individual components around the tableview, edit botton to delete and move around!!
