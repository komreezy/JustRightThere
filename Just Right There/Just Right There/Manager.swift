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
    var items: String = ""
}

var manager: Manager = Manager()

class Manager: NSObject, ListNotificationSetDelegate {
    
    //holds all of the location lists
    var lists: [list] = [list(title:"Nike Store", location: CLLocationCoordinate2D(latitude: 80.0, longitude: 80.0), items: "Shoes")]
    var notifications: [UILocalNotification] = []
    var currentIndex = 0
    
    //make blank list with title and location passed in
    func addList(titleParam: String, coordinate: CLLocationCoordinate2D){
        lists.append(list(title: titleParam, location: coordinate, items: ""))
    }
    
    func createLocationBasedNotification(name: String, radius: CGFloat) {
        let notification = UILocalNotification()
        notification.alertBody = "Don't forget about your list for \(name)!"
        notification.regionTriggersOnce = false
        let userInfo: NSDictionary = NSDictionary(object: "\(name)\(radius)", forKey: "name")
        notification.userInfo = userInfo as [NSObject : AnyObject]
        notification.region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.03118), radius: 100.0, identifier: "\(name)\(radius)")
    
        let uidToDelete = "\(name)"
        
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
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        for notification in notifications {
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        
        print("\n")
        print(UIApplication.sharedApplication().scheduledLocalNotifications)
        print("\n")
    }
}
