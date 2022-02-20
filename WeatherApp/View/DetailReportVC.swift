//
//  DetailReportVC.swift
//  WeatherApp
//
//  Created by comviva on 15/02/22.
//

import UIKit

class DetailReportVC: UIViewController {
    
    let tempViewModel = TempViewModel()
    var detailData : OpenWeather?  // contains api data
    var detailTempSetting  = ""  // contains selected temp segment from BasicReportVC
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var currentDates: UILabel!
    
    @IBOutlet weak var feelsLikeL: UILabel!
    
    @IBOutlet weak var visibilityL: UILabel!
    
    @IBOutlet weak var pressureL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting data
        currentDates.text = String(Date().formatted(date: .abbreviated, time: .omitted))

        // setting temp according to selected tempSetting
        feelsLikeL.text = tempViewModel.setTemperatur(temp: (detailData?.current.feels_like ?? 0.0), convertedTo: detailTempSetting)
        
        visibilityL.text = String(detailData?.current.visibility ?? 0)
        pressureL.text = String(detailData?.current.pressure ?? 0)
        
        tbl.dataSource = self // table datasource added
        
        
        // Do any additional setup after loading the view.
    }
}

extension DetailReportVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailData?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! DailyCustomCells
        
        // adding avg temp to a table cell --> setting temp according to selected tempSetting
        let minTemp = detailData?.daily[indexPath.row].temp.min ?? 0
        let maxTemp = detailData?.daily[indexPath.row].temp.max ?? 0
        let avgTemp = (minTemp + maxTemp) / 2
        cell.tempDetail.text = tempViewModel.setTemperatur(temp: avgTemp, convertedTo: detailTempSetting)
        
        // adding image to a table cell
        let query = detailData?.current.weather.first?.icon ?? ""
        let imageURL = String("http://openweathermap.org/img/wn/\(query)@2x.png")
        cell.imgDetail.loadcurrent(imageURL)
        
        // adding date/month/year to a table cell
        var date = Date(timeIntervalSince1970: TimeInterval(detailData?.daily[indexPath.row].dt ?? 0))
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        var localDate = dateFormatter.string(from: date)
        cell.dateDetail.text = localDate
        
        // adding weekly days to a table cell
        date = Date(timeIntervalSince1970: TimeInterval(detailData?.daily[indexPath.row].dt ?? 0))
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full //Set date style
        localDate = dateFormatter.string(from: date)
        if let index = localDate.firstIndex(of: ",") {
            let firstPart = localDate.prefix(upTo: index)
            cell.dayDetail.text = String(firstPart)
        }
        
        return cell
    }
    
    
}
