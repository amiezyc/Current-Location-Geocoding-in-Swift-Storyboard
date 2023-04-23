//
//  SearchViewController.swift
//  locationview_parknow
//
//  Created by 周雨橙 on 4/21/23.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController( vc: SearchViewController,
                               didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}
//protocol for delegate to relay the tapped location back to the other controller work with the map

class SearchViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
  
    weak var delegate: SearchViewControllerDelegate?
    // delegate property
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Request a Spot"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
        //allows you to configure your elements
        
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter destination"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        //secondary background slightly lighter
        field.leftView = UIView( frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        //padding in the field
        field.leftViewMode = .always
        return field
    }()
    
    private let tableView: UITableView = {
        //register a single
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    var locations = [Location]()
        //hold a collection of location models in this controller to drive table view content
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(label)
        view.addSubview(field)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        //assign a datasource, not only provide data but also handle interactions on the cell
        tableView.backgroundColor = .secondarySystemBackground
        field.delegate = self
    }
    //subviews
    
    override func viewDidLayoutSubviews() {
        //FRAME
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x:10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        field.frame = CGRect(x:10, y: 20 + label.frame.size.height, width: view.frame.size.width-20, height: 50)
        let tableY: CGFloat = field.frame.origin.y+field.frame.size.height+5
        tableView.frame = CGRect(x: 0, y: tableY, width: view.frame.size.width, height: view.frame.size.height-tableY)
    }
    //lay out frames
    
    func textFieldShouldReturn( _ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = field.text, !text.isEmpty{
            LocationManager.shared.findLocations(with: text){ [weak self] locations in
                //collection of locations and table view
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }//when user tap enter key we call the location
            }
        }
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return locations.count
        //number of rolls
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        cell.textLabel?.text = locations [indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        //label it's long and line wrap
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
        return cell
        //reusable cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Notify map controller to show pin at selected place
        let coordinate = locations[indexPath.row].coordinates
        //select given location in the tableview when pull up
        
        delegate?.searchViewController(vc: self,
                                       didSelectLocationWith: coordinate)
    }
    
}

