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
import Firebase

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var map: MKMapView!
    
    
    // MARK: Variables
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 5000//default value of the starting zoom
    var countryLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(55.44392), longitude: CLLocationDegrees(11.900785))
    var currentUserLocation: CLLocation!
    
    //let addresses = ["Kalkgravsvej 22, 4000 roskilde", "Fiskervejen 75,4000 Roskilde" , "Holmevej 41,3670 Veksø", "Tovesvej 30, 4220, Korsør", "Arnakkevej 31, 4593, Eskebjerg", "Åbakkevej 13, 4130, Viby Sjælland"]
    
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        self.map.userTrackingMode = MKUserTrackingMode.None
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
      
        let ref = DataService.dataService.REF_SEAS
        
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot  in
        
            //self.newAddress = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                for stuff in snapshots {
                    if let SeaDictionary = stuff.value as? Dictionary<String, AnyObject> {
                        let key = stuff.key
                        let sea = FigofySea(postKey: key, dictionary: SeaDictionary)
                        print(sea.fullAddress)
                        self.getPlacemarkFromAddress(sea.fullAddress!)
                    }
                }
            }
        })

    }
    
    override func viewWillAppear(animated: Bool) {
        self.map.delegate = self
        
    }
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    override func viewWillDisappear(animated: Bool) {
        map.showsUserLocation = false
        map.delegate = nil
    }
    
    
    // MARK: Custom Methods
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.map.showsUserLocation = true
            let region = MKCoordinateRegionMake(countryLocation, MKCoordinateSpanMake(2.0,2.0))
            let adjustedRegion: MKCoordinateRegion = map.regionThatFits(region)
            map.setRegion(adjustedRegion, animated: true)
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
            annoView.pinTintColor = UIColor(red: 255/255, green: 128/255, blue: 0/255, alpha: 1)
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
        if let currentUserLocation = currentUserLocation {
            centerMapOnLocation(currentUserLocation)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSeas" {
            let vc = segue.destinationViewController
            vc.preferredContentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 200)
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