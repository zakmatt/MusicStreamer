//
//  ReusableView.swift
//  MusicStreamer
//
//  Created by Matthew Zak on 2017-10-11.
//  Copyright © 2017 Matthew Zak. All rights reserved.
//

import Foundation

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
