//
//  SettingViewController.swift
//  IntervalTimerPro
//
//  Created by masa on 2016/06/18.
//  Copyright © 2016年 Tryworks-Design. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var exerciseTimeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
    
    var array = [[],["min"],[],["sec"]]
    var preSelectedLb:UILabel!
    var numTime:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //保存データ呼び出し
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let data = TimeData()
        
        //デシリアライズ処理
        if let storedData = userDefaults.objectForKey("timeData") as? NSData {
            if let unarchivedData = NSKeyedUnarchiver.unarchiveObjectWithData(storedData) as? TimeData {
                if let exerciseTimeString = unarchivedData.exerciseTime {
                    exerciseTimeLabel.text = exerciseTimeString
                }
                if let breakString = unarchivedData.breakTime {
                    breakTimeLabel.text = breakString
                }
                if let countString = unarchivedData.count {
                    countLabel.text = countString
                }
            }
        }
        
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        setPickerViewHidden(true)
        
        for var index = 0; index < 60; index++ {
            array[0].append(String(index))
            array[2].append(String(index))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if numTime == 3 {
            return 1
        } else {
            return array.count
        }
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array[component].count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return array[0][row]
        } else if component == 1 {
            return array[1][row]
        } else if component == 2 {
            return array[2][row]
        } else if component == 3 {
            return array[3][row]
        } else  if component == 4{
            return array[4][row]
        } else {
            return array[3][row]
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        if component == 0 {
            return setPickerLabel(0, row: row)
        } else if component == 1 {
            return setPickerLabel(1, row: row)
        } else if component == 2 {
            return setPickerLabel(2, row: row)
        } else if component == 3 {
            return setPickerLabel(3, row: row)
        } else {
            return setPickerLabel(3, row: row)
        }
    }
    

    @IBAction func tapChangeBtn(sender: AnyObject) {
        setTime(numTime)
        setPickerViewHidden(true)
    }
    
    
    @IBAction func tapCloseBtn(sender: AnyObject) {
        setPickerViewHidden(true)
    }
    
    @IBAction func tapSetBtn( sender : AnyObject ) {
        //buttonに設定されたtagを取得
        let btn:UIButton = sender as! UIButton
        numTime = btn.tag
        pickerView.reloadAllComponents()
        setPickerViewHidden(false)
    }
    
    //pickerViewのViewデザイン
    func setPickerLabel ( num : Int, row : Int) -> UILabel {
        let pickerLabel = UILabel()
        let titleData = array[num][row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HiraKakuProN-W3", size: 20.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = NSTextAlignment.Center
        pickerLabel.frame = CGRectMake(0, 0, 200, 30)
        
        return pickerLabel
    }
    
    //pickerViewの表示非表示
    func setPickerViewHidden(bool : Bool ) {
        if numTime == 1 {
            setTimeLabel(exerciseTimeLabel)
        } else if numTime == 2 {
            setTimeLabel(breakTimeLabel)
        } else if numTime == 3 {
            if let count:String = countLabel.text {
                //Countを設定する
                if let intCount: Int? = Int(count) {
                    pickerView.selectRow(intCount!, inComponent: 0, animated: true)
                }
            }
        }
        
        pickerView.hidden = bool
        backView.hidden = bool
        closeBtn.hidden = bool
        changeBtn.hidden = bool
        
    }
    
    //ラベルの時間を設定する
    func setTimeLabel ( label : UILabel) {
        if let min:String = label.text {
            //分の1文字目に"0"がある場合
            if min.componentsSeparatedByString(":")[0].substringToIndex(min.startIndex.advancedBy(1)) == "0" {
                if let intMin: Int? = Int(min.componentsSeparatedByString(":")[0].substringToIndex(min.startIndex.advancedBy(2))) {
                    pickerView.selectRow(intMin!, inComponent: 0, animated: true)
                }
            } else {
                if let intMin: Int? = Int(min.componentsSeparatedByString(":")[0]) {
                    pickerView.selectRow(intMin!, inComponent: 0, animated: true)
                }
            }
            //秒の1文字目に"0"がある場合
            if min.componentsSeparatedByString(":")[1].substringToIndex(min.startIndex.advancedBy(1)) == "0" {
                if let intMin: Int? = Int(min.componentsSeparatedByString(":")[1].substringToIndex(min.startIndex.advancedBy(2))) {
                    pickerView.selectRow(intMin!, inComponent: 2, animated: true)
                }
            } else {
                if let intMin: Int? = Int(min.componentsSeparatedByString(":")[1]) {
                    pickerView.selectRow(intMin!, inComponent: 2, animated: true)
                }
                
            }
        }
        
    }
    
    //各項目の時間を設定する
    func setTime ( tag : Int ) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let data = TimeData()
        
        
        
        //ExcrciseTime
        if tag == 1 {
            let minTime = Int(pickerView.selectedRowInComponent(0))
            let secTime = Int(pickerView.selectedRowInComponent(2))
            var minLabel:String = String(minTime)
            var secLabel:String = String(secTime)
        
            if(minTime != 0 || secTime != 0 ) {
                if minTime < 10 {
                    minLabel = "0" + String(minTime)
                }
                if secTime < 10 {
                    secLabel = "0" + String(secTime)
                }
                data.exerciseTime = minLabel + ":" + secLabel
                data.breakTime = breakTimeLabel.text
                data.count = countLabel.text
                exerciseTimeLabel.text = minLabel + ":" + secLabel
            }
        }
            
        //BreakTime
        else if tag == 2 {
            let minTime = Int(pickerView.selectedRowInComponent(0))
            let secTime = Int(pickerView.selectedRowInComponent(2))
            var minLabel:String = String(minTime)
            var secLabel:String = String(secTime)
        
            if(minTime != 0 || secTime != 0 ) {
                if minTime < 10 {
                    minLabel = "0" + String(minTime)
                }
                if secTime < 10 {
                    secLabel = "0" + String(secTime)
                }
                data.exerciseTime = exerciseTimeLabel.text
                data.breakTime = minLabel + ":" + secLabel
                data.count = countLabel.text
                breakTimeLabel.text = minLabel + ":" + secLabel
            }
        }
        
        //Count
        else if tag == 3 {
            let count = Int(pickerView.selectedRowInComponent(0))
            
            data.exerciseTime = exerciseTimeLabel.text
            data.breakTime = breakTimeLabel.text
            data.count = String(count)
            countLabel.text = String(count)
        }
        //シリアライズ処理
        let archiveData = NSKeyedArchiver.archivedDataWithRootObject(data)
        userDefaults.setObject(archiveData, forKey: "timeData")
        userDefaults.synchronize()
    }
    
}
