//
//  DailyTableViewCell.swift
//  weathergift
//
//  Created by Huiyi Victoria Lyu on 3/22/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    @IBOutlet weak var dailyHighLabel: UILabel!
    
    
    @IBOutlet weak var dailySummaryLabel: UITextView!
    
    @IBOutlet weak var dailyLowLabel: UILabel!
    
     var dailyWeather: DailyWeather! {
        didSet {
            dailyImageView.image = UIImage(named: dailyWeather.dailyIcon)
            dailyWeekdayLabel.text = dailyWeather.dailyWeekday
            dailySummaryLabel.text = dailyWeather.dailySummary
            dailyHighLabel.text = "\(dailyWeather.dailyHigh)degree"
            dailyLowLabel.text = "\(dailyWeather.dailyLow)degree"
        }
    }
    
    
    
    
}

