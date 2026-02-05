//
//  HomeVC.swift
//  Solid Waste Management
//
//  Created by Guriqbal Singh Amroke on 08.01.26.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private let demoTrucks: [(title: String, subtitle: String, lat: Double, lon: Double)] = [
        (title: "5 KM Away", subtitle: "Dry Waste", lat: 12.9655, lon: 77.5850),
        (title: "6 KM Away", subtitle: "Wet Waste", lat: 12.9900, lon: 77.5700),
        (title: "7 KM Away", subtitle: "Mix Waste", lat: 12.9750, lon: 77.6000),
        (title: "8 KM Away", subtitle: "General Waste", lat: 12.95500, lon: 77.6100)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        addDemoTruckPins()
    }
    

    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.layer.cornerRadius = 10
    }
    
    private func addDemoTruckPins() {
        
        mapView.removeAnnotations(mapView.annotations)
        
        for truck in demoTrucks {
            let annotation = MKPointAnnotation()
            annotation.title = truck.title
            annotation.subtitle = truck.subtitle
            annotation.coordinate = CLLocationCoordinate2D(latitude: truck.lat, longitude: truck.lon)
            mapView.addAnnotation(annotation)
        }
        
        if let firstTruck = demoTrucks.first {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: firstTruck.lat,
                    longitude: firstTruck.lon),
                span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
            mapView.setRegion(region, animated: true)
        }
    }

}

extension HomeVC {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "DemoTruckPin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view?.canShowCallout = true
            view?.image = UIImage(named: "garbage truck")
        } else {
            view?.annotation = annotation
        }
        return view
    }
}
