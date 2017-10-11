//
//  Track.swift
//  MusicStreamer
//
//  Created by Matthew Zak on 2017-10-11.
//  Copyright © 2017 Matthew Zak. All rights reserved.
//

import Foundation

class Track {
    fileprivate var _name: String!
    fileprivate var _duration: Int!
    
    var name: String {
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var duration: Int {
        if _duration == nil {
            return -1
        }
        return _duration
    }
    
    init(JSONTrackData: JSONStandard) {
        if let name = JSONTrackData["name"] as? String {
            _name = name
        }
        
        if let duration = JSONTrackData["duration_ms"] as? Int {
            _duration = duration / 1000
        }
    }
}
