//
//  MapViewController.swift
//  Login_SignupUI0611
//
//  Created by Aniket Patil on 16/11/23.
//

import CoreLocation
import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    @IBOutlet weak var MapView: UIView!
    @IBOutlet weak var LocationImg: UIImageView!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAaqBdcUmg0kUaD_YcGzw5pdW_MJ_2RN6Y")
    
        
        // Image tapped code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        LocationImg.addGestureRecognizer(tapGesture)
        LocationImg.isUserInteractionEnabled = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.MapView.addSubview(mapView)
        
        let kolhapurMarker = GMSMarker()
        kolhapurMarker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        kolhapurMarker.title = "Reapmind Innovation"
        kolhapurMarker.snippet = "Kolhapur"
        kolhapurMarker.map = mapView
    }
    
    @objc func imageTapped() {
        
        let DestVC = self.storyboard?.instantiateViewController(withIdentifier: "DestinationMap") as! DestinationMap
        self.navigationController?.pushViewController(DestVC, animated: true)
    }
}


