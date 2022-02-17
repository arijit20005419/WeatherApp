//
//  BasicReportVC.swift
//  WeatherApp
//
//  Created by comviva on 15/02/22.
//

import UIKit

class BasicReportVC: UIViewController {
    
    let apiViewM = ApiViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiViewM.getData()
        // Do any additional setup after loading the view.
    }

}
