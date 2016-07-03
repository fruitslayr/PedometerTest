//
//  PedometerData.swift
//  PedometerTest
//
//  Created by Francis Young on 25/06/2016.
//  Copyright © 2016 Francis Young. All rights reserved.
//

import Foundation

public class PedometerData: NSObject {
    
    public var stepsToday: Int {
        get { return stepsForEachWeekDay.last!.steps}
    }
    
    public var stepsThisWeek: Int {
        get {
            var totalSteps = 0
            
            for day in (0..<stepsForEachWeekDay.count) {
                totalSteps = totalSteps.advanced(by: stepsForEachWeekDay[day].steps)
            }
            
            return totalSteps
        }
    }
    
    private var stepsForEachWeekDay:[(date: Date, steps: Int)]!
    
    
    private var isUser: Bool!
    
    public func isUserData() -> Bool {
        return isUser
    }
    
    
    required public init (stepsForEachWeekDay: [(date: Date, steps: Int)], isUserData : Bool) {
        
        if stepsForEachWeekDay.count == 7 {
            self.stepsForEachWeekDay = stepsForEachWeekDay
        } else {
            print("stepsForEachWeekDay.count out of bounds")
        }
            self.stepsForEachWeekDay = []
        self.isUser = isUserData
    }
    
}
