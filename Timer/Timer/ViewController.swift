//
//  ViewController.swift
//  Timer
//
//  Created by Elvis Cruz on 7/16/20.
//  Copyright © 2020 Elvis Cruz. All rights reserved.


import UIKit
import AVFoundation


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var hoursMinutesSeconds: UIPickerView!
    
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var hour = 0
    var minute = 0
    var second = 0
    var timeLeft = 0
    var counter = 1
    var hours = 0
    var minutes = 0
    var seconds = 0
    var player = AVAudioPlayer()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        hoursMinutesSeconds.delegate = self
        hoursMinutesSeconds.dataSource = self
        
        timerLabel.layer.cornerRadius = 5
        timerLabel.layer.masksToBounds = true
        
        
           
        
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0 :
            return 25
        case 1,2:
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
            return "\(row) Hour"
        case 1:
            return "\(row) Minute"
        case 2:
            return "\(row) second"
        default:
            return ""
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
           switch component {
           case 0:
               hour = row
               
           case 1:
               minute = row
               
           case 2:
               second = row
           default:
               return
              
               
           }
           }
    
         
    
    
    
    
    
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        counter += 1
        
        if timeLeft == 0{
            convertTime(hour: hour, minute: minute, second: second)
        } else {
        convertTimes(hour: hours, minute: minutes, second: seconds)
        
        }
        
        
        
        if counter % 2 == 0 {
             timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
        }
       

    
        
        
    }
    
    
    func convertTime(hour: Int, minute: Int, second: Int)
    {
       
        
        timeLeft = (hour * 3600) + (minute * 60 ) + second
        
        
        
        
    }
    func convertTimes(hour: Int, minute: Int, second: Int)
       {
          
           
           timeLeft = (hours * 3600) + (minutes * 60 ) + seconds
           
           
           
           
       }
    
    
    
    @objc func updateTimer () {
       
        
        if timeLeft == 0 {
           
             hours = 0
                   minutes = 0
                   seconds = 0
                    timerLabel.text! = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
                   counter = 1
            timer.invalidate()
            playSound()
        }else {
            
            
            
           hours = timeLeft / 3600
              minutes = timeLeft / 60 % 60
             seconds = timeLeft % 60
            
            timeLeft -= 1
            
            
            
            timerLabel.text! = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
            
            
        }
        
        
        
        
        
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        timer.invalidate()
      timeLeft = 0
        hours = 0
        minutes = 0
        seconds = 0
         timerLabel.text! = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        counter = 1
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "clock", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    }
     

