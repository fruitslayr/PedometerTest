//
//  CompareStepsViewController.swift
//  PedometerTest
//
//  Created by Francis Young on 18/06/2016.
//  Copyright © 2016 Francis Young. All rights reserved.
//

import UIKit
import CoreMotion


class CompareStepsViewController: UIViewControllerWithPedoHandler, graphDataArrayDelegate {

    
    static let storyboardIdentifier = "CompareStepsViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGraphDataArray(myPedometerData: PedometerData, friendPedometerData: PedometerData, error: NSError?) {
        //update data
    }
    

}
