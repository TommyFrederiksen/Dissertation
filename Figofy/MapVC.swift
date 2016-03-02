//
//  MapVC.swift
//  Figofy
//
//  Created by Tommy on 21/01/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var map: MKMapView!
    
    
    // MARK: Variables
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000//default value of the starting zoom
    var currentUserLocation: CLLocation!
    
    let addresses = ["Kalkgravsvej 22, 4000 roskilde", "Fiskervejen 75,4000 Roskilde" , "Holmevej 41,3670 Veksø", "Tovesvej 30, 4220, Korsør", "Arnakkevej 31, 4593, Eskebjerg", "Åbakkevej 13, 4130, Viby Sjælland"]
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        self.map.userTrackingMode = MKUserTrackingMode.Follow
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        for add in addresses {
            getPlacemarkFromAddress(add)
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    
    // MARK: Custom Methods
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.map.showsUserLocation = true
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        
        self.map.setRegion(coordinateRegion, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            currentUserLocation = loc
        }
    }
    
    //calls before each annotation is placed
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //for an IMAGE
        //let reuseId = "figofy"
        //var annoView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        //annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        //annoView!.image = UIImage(named: "PinLogo")
        
        if annotation.isKindOfClass(SeaAnnotation){
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.animatesDrop = true
            return annoView
            
        } else if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        return nil
    }
    
    func createAnnotationForLocation(location: CLLocation) {
        let sea = SeaAnnotation(coordinate: location.coordinate)
        
        self.map.addAnnotation(sea)
        
    }
    
    func getPlacemarkFromAddress(address: String){
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    //we have a location with coordinates
                    self.createAnnotationForLocation(loc)
                }
            }
        }
    }
    
    // MARK: IBActions and Navigation
    @IBAction func currentLocaitonPressed(sender: AnyObject) {
        centerMapOnLocation(currentUserLocation)
    }
    
    
    @IBAction func onPopoverTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showSeas", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSeas" {
            let vc = segue.destinationViewController
            let controller = vc.popoverPresentationController
            
            if controller != nil {
                controller?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
    
    
    
    
}