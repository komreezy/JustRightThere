//
//  ListDetailCollectionViewCell.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 10/15/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListDetailCollectionViewCell: UICollectionViewCell {
    var itemNameLabel: UILabel
    
    override init(frame: CGRect) {
        itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.grayColor()
        
        addSubview(itemNameLabel)
        
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addConstraints([
            itemNameLabel.al_centerY == al_centerY,
            itemNameLabel.al_left == al_left
        ])
    }
}
