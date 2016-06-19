//
//  StepsOverviewViewController.swift
//  PedometerTest
//
//  Created by Francis Young on 18/06/2016.
//  Copyright © 2016 Francis Young. All rights reserved.
//

import UIKit
import CoreMotion


class StepsOverviewViewController: UIViewController {

    let pedometer = CMPedometer()
    
    static let storyboardIdentifier = "StepsOverviewViewController"

    @IBOutlet var totalStepsTodayLabel: UILabel!
    
    @IBAction func shareButton(){
        print("shareButton pressed")
        totalStepsTodayLabel.text = "pressed"
        
    }
    
    // MARK: Initialization
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("initializing")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        updateSteps()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateSteps(){        
        if CMPedometer.isStepCountingAvailable() {
            
            let userCalendar = Calendar.current()
            
            var components : DateComponents = userCalendar.components([.day, .month, .year], from: Date())
            
            components.hour = 0
            components.minute = 0
            components.second = 0
            
            let midnight = userCalendar.date(from: components)
            
            DispatchQueue.global(attributes: .qosUserInitiated).async {
                
                var totalSteps = ""
                
                self.pedometer.queryPedometerData(from: midnight!, to: Date(), withHandler: {data, error in
                    
                    if(error == nil){
                        totalSteps = "\(data?.numberOfSteps)"
                    }
                })

                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.totalStepsTodayLabel.text = totalSteps
                }
            }
            
        } else {
            self.totalStepsTodayLabel.text = "Unavailable"
        }
    }

}
