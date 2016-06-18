//
//  TimeData.swift
//  IntervalTimerPro
//
//  Created by masa on 2016/06/18.
//  Copyright © 2016年 Tryworks-Design. All rights reserved.
//

import Foundation

class TimeData :NSObject, NSCoding {
    var exerciseTime : String?
    var breakTime : String?
    var count : String?
    
    override init() {}
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(exerciseTime, forKey: "exerciseTime")
        aCoder.encodeObject(breakTime, forKey: "breakTime")
        aCoder.encodeObject(count, forKey: "count")
    }
    
    required init?(coder aDecoder: NSCoder) {
        exerciseTime = aDecoder.decodeObjectForKey("exerciseTime") as? String
        breakTime = aDecoder.decodeObjectForKey("breakTime") as? String
        count = aDecoder.decodeObjectForKey("count") as? String
        
    }
}