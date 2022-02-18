//
//  MainVCViewController.swift
//  WeatherApp
//
//  Created by comviva on 15/02/22.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var searchT: UITextField!
    
    @IBOutlet weak var liveLocationB: UIButton!
    
    @IBOutlet weak var locationPicker: UIPickerView!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    // imstance of View Model
    let locViewModel = LocationViewModel()
    
    let locPicker = ["Please Select Location", "America", "London", "Kolkata"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        continueBtn.isEnabled = false
        
        locationPicker.dataSource = self
        locationPicker.delegate = self
        
        searchT.delegate = self
    }
    
    // Activate when navigate icon btn is pressed
    @IBAction func liveLocationClick(_ sender: Any) {
        Task{
            do {
                if try await locViewModel.startTrackingNow(){
                    continueBtn.isEnabled = true
                    searchT.text = locViewModel.addressOfUser
                }
            } catch {
                print("Error in Location: \(error.localizedDescription)")
            }
        }
    }
    
    // Continue Btn
    @IBAction func continueClick(_ sender: Any) {
        print("Continue Btn pressed")
        if locViewModel.didLocationFound{
            if let vc = storyboard?.instantiateViewController(identifier: "basicreportvc") as? BasicReportVC{
                show(vc, sender: self)
                vc.latitude = locViewModel.coord["lat"] ?? ""
                vc.longitude = locViewModel.coord["lon"] ?? ""
            }
        }
        else{
            print("Failed")
            let alertC = UIAlertController(title: "Navigation Failed", message: "Unable to Navigate to next Screen", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertC.addAction(okAction)
            
            present(alertC, animated: true, completion: nil)
        }
    }
    
}

// Picker DataSource
extension MainVC : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locPicker.count
    }
}

// Picker Deligate
extension MainVC : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row != 0{
            Task{
                do {
                    if await locViewModel.getAddressNow(locPicker[row]){
                        searchT.text = locPicker[row]
                        continueBtn.isEnabled = true
                    }
                }
            }
        }
        else{
            searchT.text = ""
            continueBtn.isEnabled = false
        }
    }
}


// When manual entry "Continue" btn is enable
extension MainVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let search = textField.text else {
            continueBtn.isEnabled = false
            return false
        }

        Task{
            do {
                if await locViewModel.getAddressNow(search){
                    continueBtn.isEnabled = true
                }
            }
        }
        return true
    }
 
}
