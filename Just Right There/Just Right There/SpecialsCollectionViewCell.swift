//
//  SpecialsCollectionViewCell.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/19/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class SpecialsCollectionViewCell: UICollectionViewCell {
    var leftSpecialNameLabel: UILabel
    var rightSpecialNameLabel: UILabel
    var borderView: UIView
    var leftContainerView: UIView
    var rightContainerView: UIView
    var middleBorderView: UIView
    var leftContainerRightConstraint: NSLayoutConstraint?
    var small: Bool = false {
        didSet(value) {
            if value == false {
                leftContainerRightConstraint?.constant = frame.width / 2
                layoutIfNeeded()
            } else {
                leftContainerRightConstraint?.constant = 0
                layoutIfNeeded()
            }
        }
    }
    
    override init(frame: CGRect) {
        leftContainerView = UIView()
        leftContainerView.translatesAutoresizingMaskIntoConstraints = false
        leftContainerView.backgroundColor = WhiteColor
        
        rightContainerView = UIView()
        rightContainerView.translatesAutoresizingMaskIntoConstraints = false
        rightContainerView.backgroundColor = WhiteColor
        
        middleBorderView = UIView()
        middleBorderView.translatesAutoresizingMaskIntoConstraints = false
        middleBorderView.backgroundColor = GreyColor
        
        leftSpecialNameLabel = UILabel()
        leftSpecialNameLabel.translatesAutoresizingMaskIntoConstraints = false
        leftSpecialNameLabel.textColor = FlatBlackColor
        leftSpecialNameLabel.text = "Left"
        leftSpecialNameLabel.textAlignment = .Center
        
        rightSpecialNameLabel = UILabel()
        rightSpecialNameLabel.translatesAutoresizingMaskIntoConstraints = false
        rightSpecialNameLabel.textColor = FlatBlackColor
        rightSpecialNameLabel.text = "Right"
        rightSpecialNameLabel.textAlignment = .Center
        
        borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = UIColor(fromHexString: "#CCCCCC")
        
        super.init(frame: frame)
        
        leftContainerView.addSubview(leftSpecialNameLabel)
        leftContainerView.addSubview(middleBorderView)
        rightContainerView.addSubview(rightSpecialNameLabel)
        addSubview(rightContainerView)
        addSubview(leftContainerView)
        addSubview(borderView)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        leftContainerRightConstraint = leftContainerView.al_right == al_centerX
        
        addConstraints([
            leftContainerView.al_left == al_left,
            leftContainerView.al_bottom == al_bottom,
            leftContainerView.al_top == al_top,
            leftContainerRightConstraint!,

            rightContainerView.al_left == al_centerX,
            rightContainerView.al_bottom == al_bottom,
            rightContainerView.al_top == al_top,
            rightContainerView.al_right == al_right,
            
            leftSpecialNameLabel.al_right == leftContainerView.al_right,
            leftSpecialNameLabel.al_left == leftContainerView.al_left,
            leftSpecialNameLabel.al_top == leftContainerView.al_left,
            leftSpecialNameLabel.al_bottom == leftContainerView.al_bottom,
            
            rightSpecialNameLabel.al_right == rightContainerView.al_right,
            rightSpecialNameLabel.al_left == rightContainerView.al_left,
            rightSpecialNameLabel.al_top == rightContainerView.al_top,
            rightSpecialNameLabel.al_bottom == rightContainerView.al_bottom,
            
            middleBorderView.al_centerX == leftContainerView.al_right,
            middleBorderView.al_top == leftContainerView.al_top,
            middleBorderView.al_bottom == leftContainerView.al_bottom,
            middleBorderView.al_width == 0.5,
            
            borderView.al_left == al_left,
            borderView.al_width == al_width,
            borderView.al_bottom == al_bottom,
            borderView.al_height == 0.5
        ])
    }
}