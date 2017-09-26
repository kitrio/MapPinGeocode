//
//  ViewController.swift
//  MapPinGeocoding
//
//  Created by rio on 2017. 9. 26..
//  Copyright © 2017년 rio. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var lat: Double?
    var long: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let geoCoder: CLGeocoder = CLGeocoder()
        let address = "부산광역시 부산진구 범전동 시민공원로 73"
        //geoCoder.geocodeAddressString(address, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
        geoCoder.geocodeAddressString(address, completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil
            {
                print("error")
            } else
            {
                
                let myCoordinate = placemarks?[0]
                self.lat = myCoordinate?.location?.coordinate.latitude
                self.long = myCoordinate?.location?.coordinate.longitude
                
                print("country code = \(String(describing: myCoordinate))")
                print("country code = \(String(describing: myCoordinate?.timeZone))")
                
                let center = CLLocationCoordinate2DMake(self.lat! , self.long!)
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegionMake(center, span)
                self.mapView.setRegion(region, animated: true)
                
                //pin
                let anno = MKPointAnnotation()
                anno.coordinate.latitude = self.lat!
                anno.coordinate.longitude = self.long!
                anno.title = "부산시민공원"
                anno.subtitle = "공원"
                
                self.mapView.addAnnotation(anno)
                self.mapView.selectAnnotation(anno, animated: true)
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

