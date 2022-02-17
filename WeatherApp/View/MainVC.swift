import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var searchT: UITextField!
    
    @IBOutlet weak var liveLocationB: UIButton!
    
    @IBOutlet weak var locationPicker: UIPickerView!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    let locViewModel = LocationViewModel()
    
    let locPicker = ["Mumbai", "Delhi", "Kolkata"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        continueBtn.isEnabled = false
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
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
    
    
    @IBAction func continueClick(_ sender: Any) {
    }
    
}


extension MainVC : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locPicker.count
    }
}

