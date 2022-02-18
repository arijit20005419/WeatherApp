//
//  DailyCustomCells.swift
//  WeatherApp
//
//  Created by comviva on 18/02/22.
//

import UIKit

class DailyCustomCells: UITableViewCell {

    @IBOutlet weak var imgDetail: UIImageView!
    
    @IBOutlet weak var tempDetail: UILabel!
    
    @IBOutlet weak var dateDetail: UILabel!
    
    @IBOutlet weak var dayDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
