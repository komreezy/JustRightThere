//
//  Manager.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 4/4/15.
//  Copyright (c) 2015 JustRightThere. All rights reserved.
//

import UIKit
import CoreLocation

/***********************************************************************************************************************

List - a title that goes with a text field and a location
 * Each title is a String that comes from the location view controller when a user selects a place to make a list for
 * Each item list is stored as a String
 * Each Location is stored as a CLLocationCoordinate2D variable

***********************************************************************************************************************/

struct list {
    var title: String = "" //name of the place is the same as the name of the list because there is one list per place
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D() //coordinates of the place have to come from the map
    var items: [Item] = []
    var range: CGFloat
    var id: String
}

struct Item {
    var name: String
    var id: String
}

var manager: Manager = Manager()

class Manager: NSObject, ListNotificationSetDelegate {
    
    //holds all of the location lists
    var lists: [list] = []
    var notifications: [UILocalNotification] = []
    var currentIndex = 0
    
    var listsRef = rootRef.childByAppendingPath("/users")
    
    //make blank list with title and location passed in
    func addList(titleParam: String, coordinate: CLLocationCoordinate2D, id: String) {
        lists.append(list(title: titleParam, location: coordinate, items: [], range: 0.0, id: id))
    }
    
    func requestListData() {
        
        if let id = NSUserDefaults.standardUserDefaults().stringForKey("id") {
            print(id)
            listsRef = rootRef.childByAppendingPath("/users/\(id)/lists")
        }
        
        listsRef.observeEventType(.Value, withBlock: { snapshot in
            if let listsData = snapshot.value as? [String:AnyObject] {
                print(listsData)
                self.lists.removeAll()
                for (id, data) in listsData {
                    if let title = data["title"]! as? String,
                    let itemsData = data["items"]! as? [String:[String:String]] {
                        var items: [Item] = []
                        var listObject: list?
                        for(itemId, itemData) in itemsData {
                            if let name = itemData["name"]! as? String {
                                let item: Item = Item(name: name, id: itemId)
                
                                items.append(item)
                                listObject = list(title: title, location: CLLocationCoordinate2D(), items: items, range: 0.0, id: id)
                            }
                        }
                        self.lists.append(listObject!)
                    } else if let title = data["title"]! as? String {
                        let items: [Item] = []
                        var listObject: list?
                        listObject = list(title: title, location: CLLocationCoordinate2D(), items: items, range: 0.0, id: id)
                        self.lists.append(listObject!)
                    }
                }
                
                print(self.lists.count)
                print(self.lists)
                
            } else {
                print("Feed Data not received")
            }
        })
    }
    
    func createLocationBasedNotification(name: String, radius: CGFloat) {
        let userInfo: NSDictionary = NSDictionary(object: "\(name)\(radius)", forKey: "name")
        let uidToDelete = "\(name)"
        let notification = UILocalNotification()
        let radiusDouble = Double(radius)
        notification.alertBody = "Don't forget about your list for \(name)!"
        notification.regionTriggersOnce = false
        notification.userInfo = userInfo as [NSObject : AnyObject]
        notification.region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.03118), radius: (radiusDouble * 1609.34), identifier: "\(name)\(radius)")
        
        for var i = 0; i < notifications.count; i++ {
            let item = notifications[i]
            let info = item.userInfo as! [String : AnyObject]
            let uid = info["name"]! as! String
            
            if uid.containsString(uidToDelete) {
                print("\n")
                print(uid)
                print("\n")
                
                notifications.removeAtIndex(i)
            }
        }
        
        notifications.append(notification)
        lists[currentIndex].range = radius
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        for notification in notifications {
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        
        print("\n")
        print(UIApplication.sharedApplication().scheduledLocalNotifications)
        print("\n")
    }
}
