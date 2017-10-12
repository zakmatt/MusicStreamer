//
//  TrackCell.swift
//  MusicStreamer
//
//  Created by Matthew Zak on 2017-10-11.
//  Copyright © 2017 Matthew Zak. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell, ReusableView {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var track: Track!
    
    func configureCell(track: Track) {
        titleLabel.text = track.name
        coverImage.image = track.image
    }
}
