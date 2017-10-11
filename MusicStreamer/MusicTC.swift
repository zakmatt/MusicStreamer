//
//  MusicTVControllerTableViewController.swift
//  MusicStreamer
//
//  Created by Matthew Zak on 2017-10-11.
//  Copyright © 2017 Matthew Zak. All rights reserved.
//

import UIKit
import Alamofire

class MusicTC: UITableViewController {
    var searchURL = "https://api.spotify.com/v1/search?"
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAlamo(url: searchURL)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tracks.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

extension MusicTC {
    func callAlamo(url: String) {
        Alamofire.request(url, method: .get, parameters: ["q":"Linkin Park", "type":"track"], encoding: URLEncoding.default, headers: ["Authorization": TOKEN]).responseJSON { response in
            self.parsReceivedData(JSONData: response.data!)
        }
            
    }
    
    func parsReceivedData(JSONData: Data) {
        do {
            var serializedData = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let allTracks = serializedData["tracks"] as? JSONStandard {
                if let items = allTracks["items"] as? JSONStandard {
                    for item in items {
                        tracks.append(Track(JSONTrackData: (item as? JSONStandard)!))
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}
