//
//  HomeController.swift
//  weatherApp
//
//  Created by Alper Şahin on 27.03.2023.
//

import UIKit

class HomeController: UIViewController {
    
    lazy var myTemperature = UILabel()
    lazy var feelsTemperature = UILabel()
    lazy var windSpeed = UILabel()
    let thermometerImage = UIImage(named: "thermometer")
    let butClicked = UIButton()
    let api = "9d9312c7bc935be67923bbbbe4fe4b31"
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Weather API"

        tempInfo()
        feelsInfo()
        windInfo()
        buttonClicked()
  
    }
}


    

