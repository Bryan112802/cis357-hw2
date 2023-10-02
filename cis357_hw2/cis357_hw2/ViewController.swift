//
//  ViewController.swift
//  cis357_hw2
//
//  Created by Bryan Soriano and Autumn Bertram on 9/23/23.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    var latp1Val:Double = 0.0
    var latp2Val:Double = 0.0
    var longp1Val:Double = 0.0
    var longp2Val:Double = 0.0
    var bearingTemp:Double = 0.0
    var distance:Double = 0.0
    
    var distanceUnits:String = "Kilometers"
    var bearingUnits:String = "Degrees"

    @IBOutlet weak var latp1: DecimalMinusTextField!
    @IBOutlet weak var longp1: DecimalMinusTextField!
    @IBOutlet weak var latp2: DecimalMinusTextField!
    @IBOutlet weak var longp2: DecimalMinusTextField!
    
    func calculateDistance(a:(Double), b:(Double))->Double {
        let result:Double = Double(a-b)
        return (100*result).rounded()/100
    }
    
    @IBOutlet weak var distanceResult: UILabel!
    @IBOutlet weak var bearingResult: UILabel!
    
    @IBAction func calcButton(_ sender: Any) {
        latp1Val = Double(latp1.text!)!
        latp2Val = Double(latp2.text!)!

        longp1Val = Double(longp1.text!)!
        longp2Val = Double(longp2.text!)!
        
        if distanceUnits == "Kilometers" {
            distance = calculateDistance(a: latp1Val, b: latp2Val)
            distanceResult.text = String(distance) + " \(distanceUnits)"
        }
        else {
            distance = (calculateDistance(a: latp1Val, b: latp2Val)) * 0.621371
            distance = (100*distance).rounded() / 100
            distanceResult.text = String(distance) + " \(distanceUnits)"
        }
        
        let x = cos(latp2Val) * sin(abs(longp2Val - longp1Val))
        let y = cos(latp1Val) * sin(latp2Val) - sin(latp1Val) * cos(latp2Val) * cos(abs(longp2Val - longp1Val))
        
        if bearingUnits == "Degrees" {
            bearingTemp = (100*(atan2(x,y) * 180.0 / Double.pi)).rounded() / 100
            bearingResult.text = String(bearingTemp) + " \(bearingUnits)"
        }
        else {
            bearingTemp = (atan2(x,y) * 180.0 / Double.pi)
            bearingTemp = bearingTemp * (160/9)
            bearingTemp  = (100*bearingTemp).rounded() / 100
            bearingResult.text = String(bearingTemp) + " \(bearingUnits)"
        }
           
           
           self.view.endEditing(true)
       }
    
    
    
    
    @IBAction func clearButton(_ sender: Any) {
        latp1.text = ""
        latp2.text = ""
        longp1.text = ""
        longp2.text = ""
        distanceResult.text = ""
        bearingResult.text = ""
        
        
        self.view.endEditing(true)
    }
    
    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        print("Settings changed")
        self.bearingUnits = bearingUnits
        self.distanceUnits = distanceUnits
        print(bearingUnits)
        print(distanceUnits)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            print("Working")
            if let dest = segue.destination as? UINavigationController {
                if let dest = dest.topViewController as? SettingsViewController {
                    print("working2")
                        dest.delegate = self
                        dest.distanceUnits = self.distanceUnits
                        dest.bearingUnits = self.bearingUnits
                    }
            }
        }
    }
    
    
    
    
    

}
