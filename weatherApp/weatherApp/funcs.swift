//
//  setup Funcs.swift
//  weatherApp
//
//  Created by Alper Şahin on 27.03.2023.
//

import Foundation
import UIKit

extension HomeController {
    
    
    func tempInfo() {
        
        myTemperature.translatesAutoresizingMaskIntoConstraints = false
        myTemperature.text = "Sıcaklık"
        myTemperature.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(myTemperature)
        myTemperature.textColor = .black
        myTemperature.textAlignment = .center
        myTemperature.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let guide = view.safeAreaLayoutGuide
        myTemperature.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16).isActive = true
        
        let thermometerView = UIImageView(image: thermometerImage)
        thermometerView.contentMode = .scaleAspectFit
        thermometerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thermometerView)
        
        NSLayoutConstraint.activate([
            thermometerView.leftAnchor.constraint(equalTo: myTemperature.leftAnchor, constant: -30),
            thermometerView.centerYAnchor.constraint(equalTo: myTemperature.centerYAnchor),
            thermometerView.widthAnchor.constraint(equalToConstant: 30),
            thermometerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }

    func feelsInfo() {
        
        feelsTemperature.translatesAutoresizingMaskIntoConstraints = false
        feelsTemperature.text = "Hissedilen Sıcaklık"
        feelsTemperature.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(feelsTemperature)
        feelsTemperature.textColor = .black
        feelsTemperature.textAlignment = .center
        feelsTemperature.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        feelsTemperature.topAnchor.constraint(equalTo: myTemperature.bottomAnchor, constant: 100).isActive = true
        
        
    }

    func windInfo() {
        windSpeed.translatesAutoresizingMaskIntoConstraints = false
        windSpeed.text = "Rüzgar Hızı"
        windSpeed.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(windSpeed)
        windSpeed.textColor = .black
        windSpeed.textAlignment = .center
        windSpeed.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        windSpeed.topAnchor.constraint(equalTo: feelsTemperature.bottomAnchor, constant: 100).isActive = true
        
    }

    func buttonClicked() {
      
        butClicked.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(butClicked)
        butClicked.setTitle("Tıkla", for: .normal)
        butClicked.setTitleColor(.black, for: .normal)
        butClicked.backgroundColor = .white
        butClicked.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        butClicked.layer.cornerRadius = 20
        butClicked.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        butClicked.topAnchor.constraint(equalTo: windSpeed.bottomAnchor, constant: 10).isActive = true
        butClicked.widthAnchor.constraint(equalToConstant: 150).isActive = true
        butClicked.heightAnchor.constraint(equalToConstant: 50).isActive = true
        butClicked.addTarget(self, action: #selector(buttonClickedOnline), for: .touchUpInside)
      
    }
    
    @objc func buttonClickedOnline() {

        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=40.843811&lon=31.156593&appid=\(api)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("error")
                
            }
            else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                
                                if let temp = main["temp"] as? Double {
                                    self.myTemperature.text = String("Sıcaklık \(Int(temp-272.15)) Derece")
                                }
 
                                if let feels_like = main["feels_like"] as? Double {
                                    self.feelsTemperature.text = String("Hissedilen Sıcaklık \(Int(feels_like-272.15)) Derece")
                                }
                                
                            }
                            if let wind = jsonResponse!["wind"] as? [String:Any] {
                                if let speed = wind["speed"] as? Double {
                                    self.windSpeed.text = String("Rüzgar Hızı \((Int(speed))) Km / h")
                                }
                            }

                        }
                        
                    }
                    
                    catch {
                        
                    }
                }
            }
        }
        task.resume()
    }

    
    
}
    
    
    
   
