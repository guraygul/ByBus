//
//  PaymentSuccesfulViewController.swift
//  ByBus
//
//  Created by Güray Gül on 27.04.2024.
//

import UIKit
import CoreData

class PaymentSuccesfulViewController: UIViewController {
    
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personSurname: UILabel!
    @IBOutlet weak var personID: UILabel!
    
    @IBOutlet weak var ticketDate: UILabel!
    @IBOutlet weak var ticketTime: UILabel!
    @IBOutlet weak var ticketSeat: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    
    @IBOutlet weak var fromLocation: UILabel!
    @IBOutlet weak var toLocation: UILabel!
    @IBOutlet weak var busFirm: UILabel!
    @IBOutlet weak var ticketID: UILabel!
    
    @IBOutlet weak var goToTicketsPage: UIButton!
    @IBOutlet weak var goToMainPage: UIButton!
    
    var customerName = ""
    var customerSurname = ""
    var customerID = ""
    
    var fromLocationText = ""
    var toLocationText = ""
    var busFirmText = ""
    var ticketIDText = ""
    
    var ticketDateText = ""
    var ticketPriceText = 0
    var ticketTimeText = ""
    var seatNo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToTicketsPage.addTarget(self, action: #selector(goToTicketsPageButtonTapped), for: .touchUpInside)
        goToMainPage.addTarget(self, action: #selector(goToMainPageButtonTapped), for: .touchUpInside)
        
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    @objc func goToTicketsPageButtonTapped() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
    }
    
    @objc func goToMainPageButtonTapped() {
        if let navController = navigationController {
            navController.popToRootViewController(animated: true)
        }
    }
    
    func updateUI() {
        personName.text = customerName.capitalized
        personSurname.text = customerSurname.capitalized
        personID.text = customerID
        
        fromLocation.text = fromLocationText
        toLocation.text = toLocationText
        busFirm.text = busFirmText
        ticketID.text = ticketIDText
        
        ticketDate.text = ticketDateText
        ticketTime.text = ticketTimeText
        
        ticketSeat.text = seatNo
        ticketPrice.text = "\(ticketPriceText) TL"
    }
}
