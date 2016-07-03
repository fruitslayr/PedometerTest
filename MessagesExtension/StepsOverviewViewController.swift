//
//  StepsOverviewViewController.swift
//  PedometerTest
//
//  Created by Francis Young on 18/06/2016.
//  Copyright © 2016 Francis Young. All rights reserved.
//

import UIKit
import CoreMotion


class StepsOverviewViewController: UIViewControllerWithPedoHandler, updateStepsDelegate {
    
    static let storyboardIdentifier = "StepsOverviewViewController"

    @IBOutlet var stepsTodayLabel: UILabel!
    @IBOutlet var stepsThisWeekLabel: UILabel!
    
    @IBAction func shareButton(){
        if canShare {
            parentController?.shareMessage()
        } else {
            print("can't share")
        }
        
    }
    
    var canShare: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateSteps() {
        pedometerHandler!.getMyStepsToday()
        pedometerHandler!.getMyStepsThisWeek()
    }
    
    func updateStepsToday(steps: Int, error: NSError?) {
        if error == nil {
            canShare = true
            stepsTodayLabel.text = "/(steps)"
        } else {
            canShare = false
            stepsTodayLabel.text = "Unavailable"
        }
    }
    
    func updateStepsThisWeek(steps: Int, error: NSError?) {
        if error == nil {
            canShare = true
            stepsThisWeekLabel.text = "/(steps)"
        } else {
            canShare = false
            stepsThisWeekLabel.text = "Unavailable"
        }
    }

}
