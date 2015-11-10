//
//  MapSearchViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 9/4/15.
//  Copyright (c) 2015 Komran Ghahremani. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapSearchViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate,
    UISearchDisplayDelegate,
    CLLocationManagerDelegate {
    
    var mapView: MKMapView
    var searchBar: UISearchBar
    
    var locManager = CLLocationManager() //make new location manager and ask for permission
    var myLocations: [CLLocation] = []
    var listsToLoad: [String] = []
    
    var updatedLocation: Bool = false
    
    init() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.showsPointsOfInterest = true
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        var currentLoc = CLLocation() //make a variable to hold the users current location
        
        super.init(nibName: nil, bundle: nil)
        
        mapView.delegate = self
        locManager.delegate = self
        searchBar.delegate = self
        
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        let latDelta:CLLocationDegrees = 0.04
        let longDelta:CLLocationDegrees = 0.04
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            if (locManager.location != nil) {
                currentLoc = locManager.location! //if we are authorized then set the current location to our variable
                print("")
            } else {
                print("Can't find user location")
            }
        }
        
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let pointLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLoc.coordinate.latitude, currentLoc.coordinate.longitude)
        
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan) //span of the map
        mapView.setRegion(region, animated: true) //set the view of the map display
        
        view.addSubview(mapView)
        view.addSubview(searchBar)
        
        locManager.startUpdatingLocation()
        
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentLoc = CLLocation() //make a variable to hold the users current location
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        let latDelta:CLLocationDegrees = 0.04
        let longDelta:CLLocationDegrees = 0.04
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                
                if (locManager.location != nil) {
                    currentLoc = locManager.location! //if we are authorized then set the current location to our variable
                } else {
                    print("Can't find user location")
                }
                
                
        }
        
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let pointLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLoc.coordinate.latitude, currentLoc.coordinate.longitude)
        
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan) //span of the map
        mapView.setRegion(region, animated: true) //set the view of the map display
        
        searchBar.delegate = self
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                print("Error:" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(pm!)
            } else {
                print("Error with data")
            }
            
            let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
            let pointLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.locManager.location!.coordinate.latitude, self.locManager.location!.coordinate.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan) //span of the map
            
            if self.updatedLocation == false {
                for var i = 0; i < 5; i++ {
                    self.mapView.setRegion(region, animated: true) //set the view of the map display
                }
                self.updatedLocation = true
            }
        })
        
        let userLocation:CLLocation = locations[0] 
        _ = userLocation.coordinate.longitude;
        _ = userLocation.coordinate.latitude;
        print(userLocation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is CustomAnnotation {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MyCustomAnnotationView")
            
            annotationView.pinColor = MKPinAnnotationColor.Green
            annotationView.draggable = true
            annotationView.canShowCallout = true
            annotationView.animatesDrop = true
            
            let listButton = UIButton(type: UIButtonType.ContactAdd)
            listButton.frame.size.width = 44
            listButton.frame.size.height = 44
            
            annotationView.leftCalloutAccessoryView = listButton
            
            return annotationView
        }
        
        return nil
    }
    
    //If the user presses the add button on the annotation - a New List should be added to the Lists[]
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let title = view.annotation?.title,
            let coordinate = view.annotation?.coordinate {
                manager.addList(title!, coordinate: coordinate)
        }
        
        let alert: UIAlertView = UIAlertView(title: "Success!", message: "Your location has been added to your Lists. Go to 'Add to a Shopping List' to create your list for this location.", delegate: self, cancelButtonTitle: "Okay")
        alert.show()
        
        //Now go back to home screen
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        // self.locManager.stopUpdatingLocation()
        print(placemark.locality)
        print(placemark.postalCode)
        print(placemark.administrativeArea)
        print(placemark.country)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        
        let request: MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.searchBar.text
        request.region = mapView.region
        
        let search: MKLocalSearch = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({ (response: MKLocalSearchResponse?, error: NSError?) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    if let name = item.name,
                       let phone = item.phoneNumber {
                        print("Name = \(name)")
                        print("Phone = \(phone)")
                        let subtitle = "Lists: 0"
                        let itemLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                        let ann: CustomAnnotation = CustomAnnotation(coordinate: itemLocation, title: name, subtitle: subtitle)
                        self.mapView.addAnnotation(ann)
                    }
                }
            }
        })
        print("")
    }
    
    func setupLayout() {
        view.addConstraints([
            mapView.al_top == view.al_top,
            mapView.al_bottom == view.al_bottom,
            mapView.al_left == view.al_left,
            mapView.al_right == view.al_right,
            
            searchBar.al_left == view.al_left,
            searchBar.al_right == view.al_right,
            searchBar.al_top == view.al_top + 64
        ])
    }
}