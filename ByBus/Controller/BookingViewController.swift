//
//  ViewController.swift
//  ByBus
//
//  Created by Güray Gül on 21.04.2024.
//

import UIKit

class BookingViewController: UIViewController, LocationSelectionDelegate {
    
    @IBOutlet weak var fromStackView: UIStackView!
    @IBOutlet weak var toStackView: UIStackView!
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var busSearchButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var reverseLocations: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fromTap = UITapGestureRecognizer(target: self, action: #selector(fromStackViewTapped))
        fromStackView.addGestureRecognizer(fromTap)
        
        let toTap = UITapGestureRecognizer(target: self, action: #selector(toStackViewTapped))
        toStackView.addGestureRecognizer(toTap)
        
        datePicker.minimumDate = Foundation.Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    
    @objc func fromStackViewTapped() {
        print("fromStackView Tapped")
        presentSearchLocationViewController(isFromStackView: true)
    }
    
    @objc func toStackViewTapped() {
        print("toStackView Tapped")
        presentSearchLocationViewController(isFromStackView: false)
    }
    
    @IBAction func todayButtonTapped(_ sender: UIButton) {
        datePicker.date = Foundation.Date()
    }
    
    @IBAction func tomorrowButtonTapped(_ sender: UIButton) {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Foundation.Date()) else {
            return
        }
        datePicker.date = tomorrow
    }
    
    @IBAction func reverseLocationsTapped(_ sender: UIButton) {
        guard let fromLocation = fromLocationLabel.text, fromLocation != "Select Location",
              let toLocation = toLocationLabel.text, toLocation != "Select Location" else { return }
        
        fromLocationLabel.text = toLocation
        toLocationLabel.text = fromLocation
    }
    
    func presentSearchLocationViewController(isFromStackView: Bool) {
        let storyboard = UIStoryboard(name: "SearchLocation", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SearchLocation") as? SearchLocationViewController {
            vc.delegate = self
            vc.isFromStackView = isFromStackView
            
            vc.hidesBottomBarWhenPushed = true
            vc.navigationItem.title = "Search a Province"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Failed to instantiate SearchLocationViewController")
        }
    }
    
    func didSelectLocation(_ location: String, _ isFromStackView: Bool) {
        if isFromStackView {
            fromLocationLabel.text = location
        } else {
            toLocationLabel.text = location
        }
    }
    
    @IBAction func didBusSearchTapped(_ sender: UIButton) {
        guard let fromLocation = fromLocationLabel.text, !fromLocation.isEmpty, fromLocation != "Select Location",
              let toLocation = toLocationLabel.text, !toLocation.isEmpty, toLocation != "Select Location", fromLocation != toLocation else {
            
            let alertController = UIAlertController(title: "Missing or Wrong Locations", message: "Please select both from and to locations.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let storyboard = UIStoryboard(name: "BusSearch", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "BusSearch") as? BusSearchViewController {
            vc.fromLocation = fromLocation
            vc.toLocation = toLocation
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd, MMMM yyyy"
            let formattedDate = dateFormatter.string(from: datePicker.date)
            vc.ticketDate = formattedDate
            
            vc.hidesBottomBarWhenPushed = true
            vc.navigationItem.title = "Select a Bus"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

