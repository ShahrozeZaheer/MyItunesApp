//
//  MediaCollectionViewCell.swift
//  MyiTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit
import Kingfisher

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    func setup(item: Music) {
        imgItem.kf.setImage(with: URL(string: item.artworkUrl60 ?? ""))
        lblTitle.text = item.trackName
    }
    
}
