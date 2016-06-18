//
//  ViewController.swift
//  IntervalTimerPro
//
//  Created by masa on 2016/06/18.
//  Copyright © 2016年 Tryworks-Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var timeCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let data = TimeData()
        
        //デシリアライズ処理
        if let storedData = userDefaults.objectForKey("timeData") as? NSData {
            if let unarchivedData = NSKeyedUnarchiver.unarchiveObjectWithData(storedData) as? TimeData {
                if let exerciseTimeString = unarchivedData.exerciseTime {
                    print(exerciseTimeString)
                }
                if let breakString = unarchivedData.breakTime {
                    print(breakString)
                }
                if let countString = unarchivedData.count {
                    print(countString)
                }
            }
            
        //保存データがない場合
        } else {
            data.exerciseTime = "05:00"
            data.breakTime = "01:00"
            data.count = "0"
            
            
            //シリアライズ処理
            let archiveData = NSKeyedArchiver.archivedDataWithRootObject(data)
            userDefaults.setObject(archiveData, forKey: "timeData")
            userDefaults.synchronize()
            
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func restart (segue :UIStoryboardSegue) {}

}

