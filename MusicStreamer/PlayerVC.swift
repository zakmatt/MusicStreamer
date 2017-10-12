//
//  PlayerVC.swift
//  MusicStreamer
//
//  Created by Matthew Zak on 2017-10-11.
//  Copyright © 2017 Matthew Zak. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController, AVAudioPlayerDelegate {
    var track: Track!
    var trackPlayer: AVAudioPlayer!
    var isStarting = true
    var timer = Timer()
    var currentTime = 0
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var timePassedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImage.image = track.image
        coverImage.image = track.image
        titleLabel.text = track.name
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        if trackPlayer.isPlaying {
            resetAll()
        }
    }
    
    @IBAction func startPauseButtonPressed(_ sender: Any) {
        if isStarting {
            streamTrack(url: track.previewURL)
            isStarting = false
            startPauseButton.setImage(UIImage(named: "pause") , for: .normal)
            // set timer
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PlayerVC.updateProgress), userInfo: nil, repeats: true)
        } else {
            if trackPlayer.isPlaying {
                trackPlayer.pause()
                startPauseButton.setImage(UIImage(named: "play") , for: .normal)
                timer.invalidate()
            }
            else {
                trackPlayer.play()
                startPauseButton.setImage(UIImage(named: "pause") , for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PlayerVC.updateProgress), userInfo: nil, repeats: true)
            }
        }
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        resetAll()
        trackPlayer = nil
        dismiss(animated: true, completion: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        resetAll()
    }
}

extension PlayerVC {
    func playTrack(url: URL) {
        do {
            trackPlayer = try AVAudioPlayer(contentsOf: url)
            trackPlayer.delegate = self
            trackPlayer.prepareToPlay()
            trackPlayer.play()
        } catch {
            print(error)
        }
    }
    
    func streamTrack(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (handlerURL, response, error) in
            self.playTrack(url: handlerURL!)
        })
        downloadTask.resume()
    }
    
    func changeStartPauseButtonImage() {
        let iconName = trackPlayer.isPlaying ? "pause" : "play"
        startPauseButton.setImage(UIImage(named: iconName) , for: .normal)
    }
    
    func secondsToMinutesSeconds (seconds : Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func updateProgress() {
        if trackPlayer.isPlaying {
            currentTime += 1
            let (minutes, seconds) = secondsToMinutesSeconds(seconds: currentTime)
            let minutesLabel = minutes >= 10 ? "\(minutes)" : "0\(minutes)"
            let secondsLabel = seconds >= 10 ? "\(seconds)" : "0\(seconds)"
            timePassedLabel.text = "\(minutesLabel):\(secondsLabel)"
        }
    }
    
    func resetAll() {
        trackPlayer.stop()
        isStarting = true
        startPauseButton.setImage(UIImage(named: "play") , for: .normal)
        timer.invalidate()
        currentTime = 0
        timePassedLabel.text = "00:00"
    }
}
