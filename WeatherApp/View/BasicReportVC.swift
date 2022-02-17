
import UIKit

class BasicReportVC: UIViewController {

    @IBOutlet weak var LargeImageIconL: UIImageView!
    
    @IBOutlet weak var windSpeedL: UILabel!
    
    @IBOutlet weak var HumidityL: UILabel!
    
    @IBOutlet weak var feelsLikeL: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // using weather services here for fetching out the current weather Data
        
        currentWeatherUtility.instance.getCurrentWeather { [self]
            (data) in
            
            if let windSpeed = self.windSpeedL{
                windSpeed.text = String(Int(data.current.wind_speed)) + "mph"
            }
            
            if let Humidity = self.HumidityL{
                Humidity.text = String(data.current.humidity) + "%"
            }
            
            if let temp = self.feelsLikeL{
                temp.text = String(Int(data.current.feels_like)) + "°C"
            }
            let icon = data.current.weather[0].icon
            
            let Imageurl = String("http://openweathermap.org/img/wn/\(icon)@2x.png")
            
            LargeImageIconL.loadcurrent(urlString: Imageurl)

        }
        
        //ends here
        
        
        
    }

}

extension UIImageView{
    func loadcurrent(urlString:String){
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
