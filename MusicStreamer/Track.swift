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
    fileprivate var _image: UIImage!
    
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
    
    var image: UIImage {
        if _image == nil {
            return UIImage()
        }
        return _image
    }
    
    init(dictTrackData: DictStandard) {
        if let name = dictTrackData["name"] as? String {
            _name = name
        }
        
        if let duration = dictTrackData["duration_ms"] as? Int {
            _duration = duration / 1000
        }
        
        if let album = dictTrackData["album"] as? DictStandard {
            if let imagesURLs = album["images"] as? [DictStandard] {
                let imageURL = URL(string: imagesURLs[0]["url"] as! String)
                let imageData = NSData(contentsOf: imageURL!)
                _image = UIImage(data: imageData as! Data)
            }
        }
    }
}
