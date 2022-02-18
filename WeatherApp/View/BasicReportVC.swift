//
//  BasicReportVC.swift
//  WeatherApp
//
//  Created by comviva on 15/02/22.
//

import UIKit

class BasicReportVC: UIViewController {
    
    let apiViewM = ApiViewModel()
    
    var latitude : String = ""
    var longitude : String = ""
    
    @IBOutlet weak var isLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var timeZoneL: UILabel!
    
    @IBOutlet weak var dateTimeL: UILabel!
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var tempL: UILabel!
    
    @IBOutlet weak var tempIndL: UILabel!
    
    @IBOutlet weak var humidityL: UILabel!
    
    @IBOutlet weak var humidityIndL: UILabel!
    
    @IBOutlet weak var windL: UILabel!
    
    @IBOutlet weak var windIndL: UILabel!
    
    @IBOutlet weak var collectionV: UICollectionView!
    
    var countCells = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionV.dataSource = self  // adding Collection DataSource
        
        // activity indicator started
        isLoading.isHidden = false
        isLoading.startAnimating()
        isLoading.style = .large
        isLoading.color = UIColor(named: "white")
        
        // seting labels to nil
        timeZoneL.text = nil
        dateTimeL.text = nil
        weatherImg.image = nil
        tempL.text = nil
        tempIndL.text = nil
        humidityL.text = nil
        humidityIndL.text = nil
        windL.text = nil
        windIndL.text = nil
        
        apiViewM.getData(lati: latitude, longi: longitude) { data in
//            adding API data to view model
            self.apiViewM.finalData = data
            self.isLoading.stopAnimating()  // stoping indicator
            self.isLoading.isHidden = true // hiding the indicator
            
            // directly uploading the image
            let query = data?.current.weather.first?.icon ?? ""
            let imageURL = String("http://openweathermap.org/img/wn/\(query)@2x.png")
            self.weatherImg.loadcurrent(imageURL)
            
            self.timeZoneL.text = data?.timezone
            self.dateTimeL.text = Date().formatted(date: .abbreviated, time: .omitted)
            
            self.tempL.text = "Temp"
            self.tempIndL.text = "\(data?.current.temp ?? 0.0) K"
            self.humidityL.text = "Humidity"
            self.humidityIndL.text = "\(data?.current.humidity ?? 0) %"
            self.windL.text = "Wind"
            self.windIndL.text = "\(data?.current.wind_speed ?? 0.0) m/s"
            
            // counting no. of hourly cells
            self.countCells = self.apiViewM.finalData?.hourly.count ?? 0
            self.collectionV.reloadData()  // reloadig collection view
            
        }
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tempSegment(_ sender: UISegmentedControl) {
        var K = apiViewM.finalData?.current.temp ?? 0.0
        
        if sender.selectedSegmentIndex == 0{
            tempIndL.text = String(format: "%.2f", K) + " K"
        }else if sender.selectedSegmentIndex == 1{
            K = K - 273.15
            tempIndL.text = String(format: "%.2f", K) + " ℃"
        }else{
            K = (K - 273.15) * (9/5) + 32
            tempIndL.text =  String(format: "%.2f", K) + " ℉"
        }
            
    }
    
    
    @IBAction func fullReportClick(_ sender: Any) {
        // Navigating to DetailReport VC
        if let data = apiViewM.finalData {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "detailreportvc") as? DetailReportVC{
                show(vc, sender: self)
                vc.detailData = data
            }
        }
        else{
            let alertC = UIAlertController(title: "Unable to Navigate", message: "Data not Available", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertC.addAction(okAction)
            present(alertC, animated: true, completion: nil)
        }
    }
    
}

extension BasicReportVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as! HourlyCollectionCell
        
        // image setting in cell
        let query = apiViewM.finalData?.hourly[indexPath.row].weather.first?.icon ?? ""
        let imageURL = String("http://openweathermap.org/img/wn/\(query)@2x.png")
        cell.cellImg.loadcurrent(imageURL)
        
        // temp setting in cell
        let temp = String(apiViewM.finalData?.hourly[indexPath.row].temp ?? 0.0)
        cell.cellTempL.text = temp
        
        // time setting in cell
        let date = Date(timeIntervalSince1970: TimeInterval(apiViewM.finalData?.hourly[indexPath.row].dt ?? 0))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        let localDate = dateFormatter.string(from: date)
        cell.cellTimeL.text = String(localDate)
        
        return cell
    }
    
    
}

// making custom func to upload image
extension UIImageView{
    func loadcurrent(_ urlString:String){
        guard let url = URL(string: urlString) else{
            return
        }
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data(contentsOf: url)
            {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
