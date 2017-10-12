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
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAlamo(url: SEARCH_URL)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TrackCell
        let track = tracks[indexPath.row]
        cell.configureCell(track: track)
        return cell
    }
}

extension MusicTC {
    func callAlamo(url: String) {
        Alamofire.request(url, method: .get, parameters: ["q":"Linkin Park", "type":"track"], encoding: URLEncoding.default, headers: ["Authorization": TOKEN]).responseJSON { response in
            if let resultData = response.result.value as? DictStandard {
                self.parseReceivedData(DictData: resultData)
            }
        }
    }
    
    func parseReceivedData(DictData: DictStandard) {
        if let allTracks = DictData["tracks"] as? DictStandard {
            if let items = allTracks["items"] as? [DictStandard] {
                for item in items {
                    tracks.append(Track(dictTrackData: item))
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rowIndex = tableView.indexPathForSelectedRow?.row {
            if let trackDetails = segue.destination as? PlayerVC {
                let track = tracks[rowIndex]
                print(track.name)
                trackDetails.track = track
            }
        }
    }
}
