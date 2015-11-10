//
//  ListDetailHeaderView.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 10/15/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListDetailHeaderView: UICollectionReusableView, ListDetailHeaderDelegate {
    var titleLabel: UILabel // will be set by the current title variable
    var rangeSlider: UISlider // range of notification
    var borderLineView: UIView
    
    //var zeroLabel: UILabel // 10%
    var firstLabel: UILabel // 10%
    var secondLabel: UILabel // 20%
    var thirdLabel: UILabel // 30%
    var fourthLabel: UILabel // 40%
    var fifthLabel: UILabel // 50%
    var sixthLabel: UILabel // 60%
    var seventhLabel: UILabel // 70%
    var eighthLabel: UILabel // 80%
    var ninthLabel: UILabel // 90%
    var tenthLabel: UILabel // 100%
    
    var sliderNumbers = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
    var numberOfSteps: Float = 10
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Nike Store"
        titleLabel.font = UIFont.systemFontOfSize(28.0)
        titleLabel.textColor = FlatBlackColor
        titleLabel.textAlignment = .Center
        titleLabel.backgroundColor = UIColor.clearColor()
        
        rangeSlider = UISlider()
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeSlider.maximumValue = numberOfSteps - 1
        rangeSlider.minimumValue = 0
        rangeSlider.continuous = true
        rangeSlider.layer.cornerRadius = 10
        rangeSlider.tintColor = UIColor(red: 69.0/255.0, green: 74.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        rangeSlider.value = Float(manager.lists[manager.currentIndex].range)
        
        firstLabel = UILabel()
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.textAlignment = .Center
        firstLabel.text = ".5"
        firstLabel.font = UIFont.systemFontOfSize(10.0)
        
        secondLabel = UILabel()
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.textAlignment = .Center
        secondLabel.text = "1"
        secondLabel.font = UIFont.systemFontOfSize(10.0)
        
        thirdLabel = UILabel()
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.textAlignment = .Center
        thirdLabel.text = "1.5"
        thirdLabel.font = UIFont.systemFontOfSize(10.0)
        
        fourthLabel = UILabel()
        fourthLabel.translatesAutoresizingMaskIntoConstraints = false
        fourthLabel.textAlignment = .Center
        fourthLabel.text = "2"
        fourthLabel.font = UIFont.systemFontOfSize(10.0)
        
        fifthLabel = UILabel()
        fifthLabel.translatesAutoresizingMaskIntoConstraints = false
        fifthLabel.textAlignment = .Center
        fifthLabel.text = "2.5"
        fifthLabel.font = UIFont.systemFontOfSize(10.0)
        
        sixthLabel = UILabel()
        sixthLabel.translatesAutoresizingMaskIntoConstraints = false
        sixthLabel.textAlignment = .Center
        sixthLabel.text = "3"
        sixthLabel.font = UIFont.systemFontOfSize(10.0)
        
        seventhLabel = UILabel()
        seventhLabel.translatesAutoresizingMaskIntoConstraints = false
        seventhLabel.textAlignment = .Center
        seventhLabel.text = "3.5"
        seventhLabel.font = UIFont.systemFontOfSize(10.0)
        
        eighthLabel = UILabel()
        eighthLabel.translatesAutoresizingMaskIntoConstraints = false
        eighthLabel.textAlignment = .Center
        eighthLabel.text = "4"
        eighthLabel.font = UIFont.systemFontOfSize(10.0)
        
        ninthLabel = UILabel()
        ninthLabel.translatesAutoresizingMaskIntoConstraints = false
        ninthLabel.textAlignment = .Center
        ninthLabel.text = "4.5"
        ninthLabel.font = UIFont.systemFontOfSize(10.0)
        
        tenthLabel = UILabel()
        tenthLabel.translatesAutoresizingMaskIntoConstraints = false
        tenthLabel.textAlignment = .Center
        tenthLabel.text = "5"
        tenthLabel.font = UIFont.systemFontOfSize(10.0)
        
        borderLineView = UIView()
        borderLineView.translatesAutoresizingMaskIntoConstraints = false
        borderLineView.backgroundColor = UIColor(fromHexString: "#55B5B5")
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        rangeSlider.addTarget(self, action: "sliderValueChanged", forControlEvents: .TouchUpInside)
        
        addSubview(titleLabel)
        addSubview(rangeSlider)
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        addSubview(fourthLabel)
        addSubview(fifthLabel)
        addSubview(sixthLabel)
        addSubview(seventhLabel)
        addSubview(eighthLabel)
        addSubview(ninthLabel)
        addSubview(tenthLabel)
        addSubview(borderLineView)
        
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UISlider
    func sliderValueChanged() {
        UIView.animateWithDuration(0.3, animations: {
            self.rangeSlider.backgroundColor = FlatRedColor
        })
        
        var value: CGFloat = 0.0
        rangeSlider.value = floor(rangeSlider.value)
        value = CGFloat(rangeSlider.value / 2) + 0.5
        print(value)
        
        manager.createLocationBasedNotification(titleLabel.text!, radius: value)
        
        UIView.animateWithDuration(0.3, animations: {
            self.rangeSlider.backgroundColor = UIColor(fromHexString: "#ffffff")
        })
    }
    
    // MARK: ListDetailHeaderDelegate
    func fillHeaderValues(title: String) {
        titleLabel.text = title
    }
    
    func setupLayout() {
        addConstraints([
            titleLabel.al_centerX == al_centerX,
            titleLabel.al_top == al_top + 70,
            
            rangeSlider.al_left == al_left + 20,
            rangeSlider.al_right == al_right - 20,
            rangeSlider.al_top == titleLabel.al_bottom + 5,
            rangeSlider.al_height == 45,
            
            firstLabel.al_left == rangeSlider.al_left,
            firstLabel.al_top == rangeSlider.al_bottom,
            firstLabel.al_height == 30,
            firstLabel.al_width == rangeSlider.al_width / 10,
            
            secondLabel.al_left == firstLabel.al_right,
            secondLabel.al_top == rangeSlider.al_bottom,
            secondLabel.al_height == 30,
            secondLabel.al_width == rangeSlider.al_width / 10,
            
            thirdLabel.al_left == secondLabel.al_right,
            thirdLabel.al_top == rangeSlider.al_bottom,
            thirdLabel.al_height == 30,
            thirdLabel.al_width == rangeSlider.al_width / 10,
            
            fourthLabel.al_left == thirdLabel.al_right,
            fourthLabel.al_top == rangeSlider.al_bottom,
            fourthLabel.al_height == 30,
            fourthLabel.al_width == rangeSlider.al_width / 10,
            
            fifthLabel.al_left == fourthLabel.al_right,
            fifthLabel.al_top == rangeSlider.al_bottom,
            fifthLabel.al_height == 30,
            fifthLabel.al_width == rangeSlider.al_width / 10,
            
            sixthLabel.al_left == fifthLabel.al_right,
            sixthLabel.al_top == rangeSlider.al_bottom,
            sixthLabel.al_height == 30,
            sixthLabel.al_width == rangeSlider.al_width / 10,
            
            seventhLabel.al_left == sixthLabel.al_right,
            seventhLabel.al_top == rangeSlider.al_bottom,
            seventhLabel.al_height == 30,
            seventhLabel.al_width == rangeSlider.al_width / 10,
            
            eighthLabel.al_left == seventhLabel.al_right,
            eighthLabel.al_top == rangeSlider.al_bottom,
            eighthLabel.al_height == 30,
            eighthLabel.al_width == rangeSlider.al_width / 10,
            
            ninthLabel.al_left == eighthLabel.al_right,
            ninthLabel.al_top == rangeSlider.al_bottom,
            ninthLabel.al_height == 30,
            ninthLabel.al_width == rangeSlider.al_width / 10,
            
            tenthLabel.al_left == ninthLabel.al_right,
            tenthLabel.al_top == rangeSlider.al_bottom,
            tenthLabel.al_height == 30,
            tenthLabel.al_width == rangeSlider.al_width / 10,
            
            borderLineView.al_bottom == al_bottom,
            borderLineView.al_left == al_left,
            borderLineView.al_right == al_right,
            borderLineView.al_height == 3
        ])
    }
}
