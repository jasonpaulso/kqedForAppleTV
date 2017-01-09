//
//  ViewController.swift
//  kqed-test
//
//  Created by Jason Paul Southwell on 10/20/16.
//  Copyright © 2016 Jason Paul Southwell. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playingButton: UILabel!
    @IBOutlet weak var nowTemp: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    let dateFormatter = DateFormatter()
    var player:AVPlayer?
    var playState:Int?
//    var weatherData:AnyObject?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playState = 0
        startClock()
        stopPlayer()
        pressPlay()
//        getWeather()
//        logInToNPR()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }

//    func getWeather() {
//        Alamofire.request("https://api.darksky.net/forecast/db9820540c1c18b4d4eaf24dbdd69032/37.8267,-122.4233").responseJSON { response in
//            debugPrint(response)
//            let weatherData = JSON(response.result.value!)
//            let forecastData = weatherData["currently"]["temperature"].intValue
////            let todayData = weatherData["current_observation"]["temp_f"]
//            self.weatherLabel.text = "Current Temperature:" + " " + String(forecastData) + "f"
//            print("Data", forecastData)
////            self.nowTemp.text = String(round(todayData.doubleValue))
//            
//        }
//    }
    
    func setBackground() {
        
        //        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        //        backgroundImage.image = #imageLiteral(resourceName: "kqed")
        //        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func startClock() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats:true);
    }
    

    
    func updateTimeLabel() -> Void {
        timeLabel.text = dateFormatter.string(from: Date());
    }
    
    @IBAction func btnPress(_ sender: Any) {
        pressPlay()
    }
    
    func pressPlay() {
        if (self.playState == 0) {
            initPlayer(station: "kqed")
            btnPlay.setTitle("Stop", for: UIControlState.normal)
        } else {
            stopPlayer()
            btnPlay.setTitle("Play", for: UIControlState.normal)
        }
    }
    
    func initPlayer(station: String)  {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        if let play = player {
            play.play()
        } else {
            print("player allocated")
            if (station == "kqed") {
                player = AVPlayer(url: NSURL(string: "http://streams.kqed.org/kqedradio.m3u")! as URL)
                print(station, ": playing")
            } else {
                player = AVPlayer(url: NSURL(string: "http://streams.kqed.org/kqedradio.m3u")! as URL)
                print("kqed is not playing")

            }
            player!.play()
            self.playState = 1
        }
    }
    
    func stopPlayer() {
        if let play = player {
            print("stopped")
            play.pause()
            player = nil
            print("player deallocated")
            self.playState = 0
        } else {
            print("player was already deallocated")
        }
    }
    
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        
        if(presses.first?.type == UIPressType.playPause) {
            pressPlay()
            
        } else {
            
            super.pressesBegan(presses, with: event)
        }
    }
  
    
}

