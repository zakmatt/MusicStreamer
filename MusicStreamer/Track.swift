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
    fileprivate var _duration = 30
    fileprivate var _image: UIImage!
    fileprivate var _previewURL: URL!
    
    var name: String {
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var duration: Int {
        return _duration
    }
    
    var image: UIImage {
        if _image == nil {
            return UIImage()
        }
        return _image
    }
    
    var previewURL: URL {
        if _previewURL == nil {
            return URL(string: "")!
        }
        return _previewURL
    }
    
    init(dictTrackData: DictStandard) {
        if let name = dictTrackData["name"] as? String {
            _name = name
        }
        
        if let previewURL = dictTrackData["preview_url"] as? String {
            _previewURL = URL(string: previewURL)
        }
        
        if let album = dictTrackData["album"] as? DictStandard {
            if let imagesURLs = album["images"] as? [DictStandard] {
                let imageURL = URL(string: imagesURLs[0]["url"] as! String)
                let imageData = NSData(contentsOf: imageURL!)
                _image = UIImage(data: imageData! as Data)
            }
        }
    }
}
