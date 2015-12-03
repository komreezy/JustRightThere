//
//  ListDetailViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 9/10/15.
//  Copyright (c) 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListDetailViewController: UICollectionViewController,
DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource, UITextFieldDelegate {

    // variables passed in from the last view controller
    var currentItems: [Item]
    var currentTitle: String
    var currentIndex: Int
    var currentItemIndex: Int = 0
    var addButton: UIBarButtonItem?
    
    var delegate: ListNotificationSetDelegate?
    var headerDelegate: ListDetailHeaderDelegate?
    var headerView: ListDetailHeaderView?
    
    init() {
        currentIndex = manager.currentIndex
        
        currentItems = manager.lists[currentIndex].items
        
        currentTitle = manager.lists[currentIndex].title
        
        super.init(collectionViewLayout: ListDetailViewController.provideCollectionViewLayout())
        
        addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem")
        navigationItem.rightBarButtonItem = addButton
        
        view.backgroundColor = UIColor.whiteColor()
        
        delegate = manager
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myNavigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: WhiteColor]
        title = "Detail"
        
        if let collectionView = collectionView {
            collectionView.backgroundColor = UIColor.whiteColor()
            collectionView.emptyDataSetSource = self
            collectionView.emptyDataSetDelegate = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.registerClass(ListDetailHeaderView.self, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "profile-header")
            collectionView.registerClass(ListDetailCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidAppear(animated: Bool) {
        currentItems = manager.lists[currentIndex].items
        
        if let collectionView = collectionView {
            collectionView.reloadData()
        }
    }
    
    class func provideCollectionViewLayout() -> UICollectionViewLayout {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let flowLayout = CSStickyHeaderFlowLayout()
        flowLayout.parallaxHeaderMinimumReferenceSize = CGSizeMake(screenWidth, 200)
        flowLayout.parallaxHeaderReferenceSize = CGSizeMake(screenWidth, 270)
        flowLayout.parallaxHeaderAlwaysOnTop = true
        flowLayout.disableStickyHeaders = false
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        flowLayout.itemSize = CGSizeMake(screenWidth, 80)
        return flowLayout
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("listCell", forIndexPath: indexPath) as! ListDetailCollectionViewCell
        
        cell.itemNameLabel.text = currentItems[indexPath.row].name
        cell.itemNameLabel.delegate = self
        cell.itemNameLabel.tag = indexPath.row
        
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
    
    // MARK: CellTextField
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let id = NSUserDefaults.standardUserDefaults().stringForKey("id") {
            currentItemIndex = textField.tag
            let listId = manager.lists[manager.currentIndex].id
            let itemRef = rootRef.childByAppendingPath("users/\(id)/lists/\(listId)/items/\(manager.lists[manager.currentIndex].items[currentItemIndex].id)/name")
        
            if let newItemText = textField.text {
                manager.lists[manager.currentIndex].items[currentItemIndex].name = newItemText
                itemRef.setValue(newItemText)
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: DZNEmptyDataSet
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "No Items yet"
        let myMutableString = NSMutableAttributedString(
            string: title,
            attributes: [NSFontAttributeName:UIFont(
                name: "HelveticaNeue",
                size: 24.0)!, NSForegroundColorAttributeName: FlatBlackColor])
        return myMutableString
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "Get your list started and add your first item by tapping on the plus button in the top right hand corner of your screen."
        let myMutableString = NSMutableAttributedString(
            string: title,
            attributes: [NSFontAttributeName:UIFont(
                name: "HelveticaNeue",
                size: 18.0)!, NSForegroundColorAttributeName: FlatBlackColor])
        return myMutableString
    }
    
    
    //if the user forgets to put the done button and they click back then it's ok it still saves
    override func viewDidDisappear(animated: Bool) {
        // manager.lists[currentIndex].items = textView.text
    }
    
    //if the user clicks the done button then save their list that they wrote
    func doneButtonClicked(sender: UIButton){
        // manager.lists[currentIndex].items = textView.text
    }
    
    func addItem() {
        presentViewController(AddItemViewController(), animated: true, completion: nil)
    }
}

protocol ListNotificationSetDelegate {
    func createLocationBasedNotification(name: String, radius: CGFloat)
}

protocol ListDetailHeaderDelegate {
    func fillHeaderValues(title: String)
}
