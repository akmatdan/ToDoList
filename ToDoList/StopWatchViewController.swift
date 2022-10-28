//
//  StopWatchViewController.swift
//  ToDoList
//
//  Created by Daniil Akmatov on 28/10/22.
//

import UIKit

class StopWatchViewController: UIViewController {

    @IBOutlet var TimerLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var timePicker: UIPickerView!
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var stopWatch: Bool = true
    var isActiveStop: Bool = false
    var isActivePlay: Bool = false
    var isActiveReset: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.isHidden = true
        
    }

    @IBAction func didChangeSegmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            timePicker.isHidden = true
            stopWatch = true
            timerCounting = false
            
            count = 0
            timer.invalidate()
            TimerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        }
        else if sender.selectedSegmentIndex == 1 {
            timePicker.isHidden = false
            timePicker.delegate = self
            timePicker.dataSource = self
            stopWatch = false
            timerCounting = false
            
            count = 0
            timer.invalidate()
            TimerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        }
    }

    @IBAction func resetTapped(_ sender: Any) {
        timerCounting = false
        count = 0
        timer.invalidate()
        TimerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        
        if(stopWatch == false) {
            timePicker.isHidden = false
            self.timePicker.selectRow(0, inComponent: 0, animated: true)
            self.timePicker.selectRow(0, inComponent: 1, animated: true)
            self.timePicker.selectRow(0, inComponent: 2, animated: true)
        }
        
        if isActiveReset {
            isActiveReset = false
            resetButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        } else {
            isActiveReset = true
            resetButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            
            isActivePlay = false
            playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
            isActiveStop = false
            stopButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
    
    @IBAction func pauseTapped(_ sender: Any) {
        timerCounting = false
        timer.invalidate()
        
        if(stopWatch == false) {
            timePicker.isHidden = false
        }
        
        if isActiveStop {
            isActiveStop = false
            stopButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        } else {
            isActiveStop = true
            stopButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            
            isActivePlay = false
            playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
            isActiveReset = false
            resetButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        timePicker.isHidden = true
        
        if isActivePlay {
            isActivePlay = false
            playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
        } else {
            isActivePlay = true
            playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            
            isActiveStop = false
            stopButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            
            isActiveReset = false
            resetButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        }
    }
    
    @objc func timerCounter() -> Void {
        if(stopWatch == true){
            count += 1
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            TimerLabel.text = timeString
            
        } else {
            
            if stopWatch == false {
                isActivePlay = false
                playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
                isActiveStop = false
                stopButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
                isActiveReset = false
                resetButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            }
            
            let time = secondsToHoursMinutesSeconds(seconds: count)
            
            var h = time.0 + hours
            var m = time.1 + minutes
            var s = time.2 + seconds
            
            if h == 0 && m == 0 && s == 0 {
                timerCounting = false
                count = 0
                h = 0
                m = 0
                s = 0
                timer.invalidate()
                TimerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
                timePicker.isHidden = false
                self.timePicker.selectRow(0, inComponent: 0, animated: true)
                self.timePicker.selectRow(0, inComponent: 1, animated: true)
                self.timePicker.selectRow(0, inComponent: 2, animated: true)
            }
            
            else if s > 0 {
                repeat {
                    count -= 1
                }while s == 0
                s -= 1
            }
            else if m > 0 {
                repeat {
                    s += 59
                    count -= 1
                } while m == 0
                m -= 1
            }
            else if h > 0 {
                repeat {
                    m += 59
                    s += 59
                   count -= 1
                } while h == 0
                h -= 1
            }
                
            let timeString = makeTimeString(hours: h, minutes: m, seconds: s)
            TimerLabel.text = timeString
        }
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

extension StopWatchViewController: UIPickerViewDelegate, UIPickerViewDataSource {

     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 3
     }

     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         switch component {
         case 0:
             return 25
         case 1, 2:
             return 60
         default:
             return 0
         }
     }

     func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
         return pickerView.frame.size.width/3
     }

     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         switch component {
         case 0:
             return "\(row) h"
         case 1:
             return "\(row) m"
         case 2:
             return "\(row) s"
         default:
             return ""
         }
     }
    
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         switch component {
         case 0:
             hours = row
         case 1:
             minutes = row
         case 2:
             seconds = row
         default:
             break;
         }
     }
 }
