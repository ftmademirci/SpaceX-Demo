//
//  CollectionViewCell.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var launchImageView: UIImageView!
    @IBOutlet var launchTitle: UILabel!
    @IBOutlet var launchDescription: UILabel!
    @IBOutlet var launchDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
