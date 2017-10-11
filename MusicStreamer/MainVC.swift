//
//  ViewController.swift
//  MusicStreamer
//
//  Created by Matthew Zak on 2017-10-10.
//  Copyright © 2017 Matthew Zak. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessful"), object: nil)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if UIApplication.shared.openURL(loginUrl!) {
            if auth.canHandle(auth.redirectURL) {
                
            }
        }
    }
}

extension MainVC {
    
    func setup() {
        SPTAuth.defaultInstance().clientID = CLIENT_ID
        SPTAuth.defaultInstance().redirectURL = URL(string: REDIRECT_URL)
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope,
                                                     SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
    func updateAfterFirstLogin () {
        
        loginButton.isHidden = true
        let userDefaults = UserDefaults.standard
        
        if let sessionObj: AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
        }
        performSegue(withIdentifier: "MusicTC", sender: nil)
    }
}

