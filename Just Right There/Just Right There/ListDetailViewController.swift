//
//  ListDetailViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 9/10/15.
//  Copyright (c) 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListDetailViewController: UICollectionViewController {

    // variables passed in from the last view controller
    var currentText: String
    var currentTitle: String
    var currentIndex: Int
    
    var delegate: ListNotificationSetDelegate?
    var headerDelegate: ListDetailHeaderDelegate?
    var headerView: ListDetailHeaderView?
    
    var currentItems = ["Shoes", "Shirt", "Golf Balls", "Jordans", "Ankle Socks", "Hat", "Headband", "Tennis Ball"]
    
    init() {
        currentIndex = manager.currentIndex
        
        currentText = manager.lists[currentIndex].items
        
        currentTitle = manager.lists[currentIndex].title
        
        super.init(collectionViewLayout: ListDetailViewController.provideCollectionViewLayout())
        
        view.backgroundColor = UIColor.whiteColor()
        
        delegate = manager
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = collectionView {
            collectionView.backgroundColor = UIColor.whiteColor()
            collectionView.showsVerticalScrollIndicator = false
            collectionView.registerClass(ListDetailHeaderView.self, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "profile-header")
            collectionView.registerClass(ListDetailCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    class func provideCollectionViewLayout() -> UICollectionViewLayout {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let flowLayout = CSStickyHeaderFlowLayout()
        flowLayout.parallaxHeaderMinimumReferenceSize = CGSizeMake(screenWidth, 200)
        flowLayout.parallaxHeaderReferenceSize = CGSizeMake(screenWidth, 270)
        flowLayout.parallaxHeaderAlwaysOnTop = false
        flowLayout.disableStickyHeaders = false
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        flowLayout.itemSize = CGSizeMake(screenWidth, 80)
        return flowLayout
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("listCell", forIndexPath: indexPath) as! ListDetailCollectionViewCell
        
        cell.itemNameLabel.text = currentItems[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentItems.count
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == CSStickyHeaderParallaxHeader {
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "profile-header", forIndexPath: indexPath) as! ListDetailHeaderView
            
            if headerView == nil {
                headerView = cell
                headerDelegate = headerView
                headerDelegate?.fillHeaderValues(currentTitle)
            }
            
            return headerView!
        } else {
            return UICollectionReusableView()
        }
    }
    
    //if the user forgets to put the done button and they click back then it's ok it still saves
    override func viewDidDisappear(animated: Bool) {
        // manager.lists[currentIndex].items = textView.text
    }
    
    //if the user clicks the done button then save their list that they wrote
    func doneButtonClicked(sender: UIButton){
        // manager.lists[currentIndex].items = textView.text
    }
}

protocol ListNotificationSetDelegate {
    func createLocationBasedNotification(name: String, radius: CGFloat)
}

protocol ListDetailHeaderDelegate {
    func fillHeaderValues(title: String)
}
