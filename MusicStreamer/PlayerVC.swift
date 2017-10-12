//
//  PlayerVC.swift
//  MusicStreamer
//
//  Created by Matthew Zak on 2017-10-11.
//  Copyright © 2017 Matthew Zak. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    var track: Track!
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startPauseButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImage.image = track.image
        coverImage.image = track.image
        titleLabel.text = track.name
    }
    @IBAction func stopButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func startPauseButtonPressed(_ sender: Any) {
        
    }
    

}
