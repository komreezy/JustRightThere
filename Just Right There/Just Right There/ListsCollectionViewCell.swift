//
//  ListsCollectionViewCell.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 9/10/15.
//  Copyright (c) 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListsCollectionViewCell: UICollectionViewCell {
    var nameLabel: UILabel
    var itemCountLabel: UILabel
    
    override init(frame: CGRect) {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Nike"
        
        itemCountLabel = UILabel()
        itemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        itemCountLabel.text = "3 Items"
        
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(itemCountLabel)
        
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addConstraints([
            nameLabel.al_centerY == al_centerY,
            nameLabel.al_left == al_left + 25,
            
            itemCountLabel.al_centerY == al_centerY,
            itemCountLabel.al_right == al_right - 25
        ])
    }
}
