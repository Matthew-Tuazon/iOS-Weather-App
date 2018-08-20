//
//  ViewController.swift
//  Weather-App
//
//  Created by Matt Tuazon on 8/20/18.
//  Copyright © 2018 Matt Tuazon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        getWeather()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getWeather() {
    let session = URLSession.shared
    let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Bergenfield,us?&units=imperial&APPID={YOUR_API_KEY_HERE}")! //Writes out a URL session
        let dataTask = session.dataTask(with: weatherURL) { //takes API call
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else {
            if let data = data {
                let dataString = String(data: data, encoding: String.Encoding.utf8) //for easy string print to console
                
                    print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                    self.weatherLabel.text = "Bergenfield Temperature: \(temperature)°F"
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                    } else {
                        print("Error: unable to convert json data")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
    }
}
        
        
        

    


