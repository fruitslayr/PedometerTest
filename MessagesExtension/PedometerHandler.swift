//
//  PedometerHandler.swift
//  PedometerTest
//
//  Created by Francis Young on 25/06/2016.
//  Copyright © 2016 Francis Young. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

public class PedometerHandler: NSObject {
    
    var friendPedometerData: PedometerData?
    var myPedometerData: PedometerData?
    
    let pedometer: CMPedometer = CMPedometer()
    
    weak var parent: UIViewController! //Either MessagesViewController || StepsOverviewViewController
    
    private var canAccessPedometerData: Bool {
        get {
            return CMPedometer.isStepCountingAvailable()
        }
    }
    
    public func getMyStepsToday(){
        //check to see if myPedometerData has been created before
        let parentController = parent as! StepsOverviewViewController
        if myPedometerData != nil {
            parentController.updateStepsToday(steps: (myPedometerData?.stepsToday)!, error: nil)
        } else {
            
            if canAccessPedometerData {
                let userCalendar = Calendar.current()
    
                var components : DateComponents = userCalendar.components([.day, .month, .year], from: Date())
    
                components.hour = 0
                components.minute = 0
                components.second = 0
    
                let midnight = userCalendar.date(from: components)
    
                DispatchQueue.global(attributes: .qosUserInitiated).async {
    
                    var totalSteps: Int = 0
    
                    self.pedometer.queryPedometerData(from: midnight!, to: Date(), withHandler: {data, error in
                        if(error == nil){ totalSteps = Int((data?.numberOfSteps)!)}
                    })
                    
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async { parentController.updateStepsToday(steps: totalSteps, error: nil)}
                }

            } else { parentController.updateStepsToday(steps: 0, error: NSError())}
        }
    }
    
    public func getMyStepsThisWeek() {
        let parentController = parent as! StepsOverviewViewController
        
        //check to see if myPedometerData has been created before
        if myPedometerData != nil {
            parentController.updateStepsToday(steps: (myPedometerData?.stepsToday)!, error: nil)
        } else {
            
            if canAccessPedometerData {
                let userCalendar = Calendar.current()
                
                var components : DateComponents = userCalendar.components([.day, .month, .year], from: Date())
                
                components.hour = 0
                components.minute = 0
                components.second = 0
                
                var midnight = userCalendar.date(from: components)
                
                
                DispatchQueue.global(attributes: .qosUserInitiated).async {
                    
                    var totalSteps: [(date: Date, steps: Int)] = []
                    var totalStepCount = 0
                    
                    for _ in 0..<7 {
                        self.pedometer.queryPedometerData(from: midnight!, to: Date(), withHandler: {data, error in
                            if(error == nil){
                                totalSteps.insert((midnight!, Int((data?.numberOfSteps)!)), at: totalSteps.count)
                                totalStepCount += Int((data?.numberOfSteps)!)
                            }
                        })
                        midnight = userCalendar.date(byAdding: .day, value: -1, to: midnight!, options: [])
                    }
                   
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
                        parentController.updateStepsToday(steps: totalStepCount, error: nil)
                        self.myPedometerData = PedometerData(stepsForEachWeekDay: totalSteps, isUserData: true)
                    }
                }
                
            } else { parentController.updateStepsThisWeek(steps: 0, error: NSError())}
        }
    }
    
}

protocol updateStepsDelegate {
    func updateStepsToday(steps: Int, error: NSError?)
    
    func updateStepsThisWeek(steps: Int, error: NSError?)
}

protocol graphDataArrayDelegate {
    func updateGraphDataArray(myPedometerData: PedometerData, friendPedometerData: PedometerData, error: NSError?)
}

