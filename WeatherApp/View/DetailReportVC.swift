
import UIKit

class DetailReportVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var WeeklyTable: UITableView!
    
    // table to show weekly data
    
    var weeklyWeatherList : [DailyWeatherData] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        WeaklyWeatherUtility.instance.getWeaklyWeather { data in
            
            self.weeklyWeatherList = data.daily
            
            self.WeeklyTable.reloadData()
            
        }
        
        WeeklyTable.dataSource = self

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyTempratureCell", for: indexPath) as! WeeklyTempratureCell
        
        let weeklyWeather = weeklyWeatherList[indexPath.row]
        
        // conversion of unix utc to local Date and time
        
        let unixdate : Double = Double(weeklyWeather.dt)

        let date = NSDate(timeIntervalSince1970: unixdate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd-MM-yyyy"

        let stringDate: String = dateFormatter.string(from: date as Date)
        
        let StringDateWithWeekday = stringDate.split(separator: " ")
        
        
        cell.DateL.text = String(StringDateWithWeekday[1])
        
        cell.dayL.text = String(StringDateWithWeekday[0])
        
        cell.TempL.text = String(Int(weeklyWeather.temp.day))
        
        let icon = weeklyWeather.weather[0].icon
        
        let Imageurl = String("http://openweathermap.org/img/wn/\(icon)@2x.png")
        
        cell.iconImageL.loadWeekly(urlString: Imageurl)
        
        return cell
    }

}

extension UIImageView{
    func loadWeekly(urlString:String){
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
