//
//  ViewController.swift
//  locationview_parknow
//
//  Created by 周雨橙 on 4/21/23.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation

class ViewController: UIViewController, SearchViewControllerDelegate {
    
    let mapView = MKMapView()
    let panel = FloatingPanelController()
    //creating panel controler as globle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        title = "PARKNOW"
        
        let searchVC = SearchViewController()
        searchVC.delegate = self
        panel.set(contentViewController: SearchViewController())
        panel.addPanel(toParent: self)
        //add floating panel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
        //frame that help the map take over the entire screen
    }
    
    func searchViewController(vc: SearchViewController, didSelectLocationWith coordinates:
                              CLLocationCoordinate2D?) {
        
        guard let coordinates = coordinates else{
            return
        }
        
        panel.move(to: .tip, animated: true)
        //dismiss panel controller
        
        mapView.removeAnnotations(mapView.annotations)
        //get rid of all pin
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        
        mapView.setRegion(MKCoordinateRegion(center: coordinates
                                             , span: MKCoordinateSpan(
                                                latitudeDelta: 0.7,
                                                longitudeDelta: 0.7
                                             )
                                            ),
                          animated: true)
        //how muc map you want to show
    }
}

