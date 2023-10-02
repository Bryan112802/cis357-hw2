//
//  SettingsViewController.swift
//  cis357_hw2
//
//  Created by Bryan Soriano and Autumn Bertram on 9/24/23.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(distanceUnits: String, bearingUnits: String)
}

class SettingsViewController: UIViewController{
    
    @IBOutlet weak var distanceText: UILabel!
    @IBOutlet weak var bearingText: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    
    
    var pickerData: [String] = [String]()
    var distanceUnits: String = ""
    var bearingUnits: String = ""
    var delegate : SettingsViewControllerDelegate?
    
    var originalDistanceText:String = ""
    var originalBearingText:String = ""
    
    
    var selectedDistanceRow = 0
    var selectedBearingRow = 0
    



    override func viewDidLoad() {
        super.viewDidLoad()

        picker.dataSource = self
        picker.delegate = self

        
        distanceText.text = distanceUnits
        bearingText.text = bearingUnits


        let distanceTapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        distanceText.isUserInteractionEnabled = true
        distanceText.addGestureRecognizer(distanceTapGesture)
        let bearingTapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        bearingText.isUserInteractionEnabled = true
        bearingText.addGestureRecognizer(bearingTapGesture)
        
        originalDistanceText = distanceText.text!
        originalBearingText = bearingText.text!
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOutside(_:)))
            view.addGestureRecognizer(tapGestureRecognizer)
    
            
        }
    
    @IBAction func cancelButton(_ sender: Any) {
        distanceUnits = originalDistanceText
        bearingUnits = originalBearingText
        self.navigationController?.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)

           if let d = self.delegate {
               d.settingsChanged(distanceUnits: distanceUnits, bearingUnits: bearingUnits)
           }
       }
    
    
    
    @objc func tapOutside(_ sender: UITapGestureRecognizer) {
        let tap = sender.location(in: view)
        
        if !picker.frame.contains(tap) && !distanceText.frame.contains(tap) && !bearingText.frame.contains(tap) {
            picker.isHidden = true
        }
    }

    
    @objc func tap(_ text: UITapGestureRecognizer) {

            if text.view == distanceText {
                picker.tag = 0
                self.pickerData = ["Kilometers", "Miles"]
                let selected = picker.selectedRow(inComponent: 0)
                distanceText.text = pickerData[selected]
                distanceUnits = distanceText.text!
                print(distanceUnits)
                picker.selectRow(selectedDistanceRow, inComponent: 0, animated: true)
            }
            else if text.view == bearingText {
                picker.tag = 1
                self.pickerData = ["Degrees", "Mils"]
                let selected = picker.selectedRow(inComponent: 0)
                bearingText.text = pickerData[selected]
                bearingUnits = bearingText.text!
                print(bearingUnits)
                picker.selectRow(selectedBearingRow, inComponent: 0, animated: true)

            }
        
        
            picker.reloadAllComponents()
            
            if picker.isHidden {
                picker.isHidden = false
            }
            else {
                picker.isHidden = true
            }

        }
    
    

    @IBAction func saveButton(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
    }
  
    }


    

    
    
    
    
    
    






extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
                self.distanceUnits = self.pickerData[row]
            } else if pickerView.tag == 1 {
                self.bearingUnits = self.pickerData[row]
            }
    }
    
}


