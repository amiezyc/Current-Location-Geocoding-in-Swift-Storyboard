//
//  ContentView.swift
//  park_now
//
//  Created by 周雨橙 on 4/21/23.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    // CLLocationManagerDelegate methods
    // ...
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Show an alert to the user explaining why location access is necessary
            // and how to grant it in the Settings app
            break
        case .notDetermined:
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else { return }
        // Do something with the location data
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location-related errors
    }
}

class RegistrationViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up text field delegates
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneTextField.delegate = self
        languageTextField.delegate = self
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        // Get user input from text fields
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let language = languageTextField.text ?? ""

        // TODO: Validate user input

        // Send verification SMS to user's phone number
        sendVerificationSMS(to: phone)

        // Save user preferences to local storage or a backend database
        saveUserPreferences(firstName: firstName, lastName: lastName, phone: phone, language: language)

        // TODO: Show confirmation message to user
    }

    private func sendVerificationSMS(to phone: String) {
        // TODO: Implement SMS verification using a third-party provider
    }

    private func saveUserPreferences(firstName: String, lastName: String, phone: String, language: String) {
        // TODO: Save user preferences to local storage or a backend database
    }
}

extension RegistrationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when the user taps the Return key
        textField.resignFirstResponder()
        return true
    }
}


