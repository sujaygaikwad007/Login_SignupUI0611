//
//  DestinationMap.swift
//  Login_SignupUI0611
//
//  Created by Aniket Patil on 17/11/23.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class DestinationMap: UIViewController, CLLocationManagerDelegate{

    let manager = CLLocationManager()

    @IBOutlet weak var DestMapView: UIView!
    @IBOutlet weak var SearchTool: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        GMSServices.provideAPIKey("AIzaSyAaqBdcUmg0kUaD_YcGzw5pdW_MJ_2RN6Y")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.DestMapView.addSubview(mapView)

        let kolhapurMarker = GMSMarker()
        kolhapurMarker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        kolhapurMarker.title = "Reapmind Innovation"
        kolhapurMarker.snippet = "Kolhapur"
        kolhapurMarker.map = mapView
    }
}
