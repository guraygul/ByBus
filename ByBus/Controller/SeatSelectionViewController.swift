//
//  SeatSelectionViewController.swift
//  ByBus
//
//  Created by Güray Gül on 26.04.2024.
//

import UIKit
import CoreData

class SeatSelectionViewController: UIViewController {
    
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var ticketDateLabel: UILabel!
    @IBOutlet weak var ticketHourLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var selectedSeatLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var seatNoOne: SeatUIView!
    @IBOutlet weak var seatNoTwo: SeatUIView!
    @IBOutlet weak var seatNoThree: SeatUIView!
    @IBOutlet weak var seatNoFour: SeatUIView!
    @IBOutlet weak var seatNoFive: SeatUIView!
    @IBOutlet weak var seatNoSix: SeatUIView!
    @IBOutlet weak var seatNoSeven: SeatUIView!
    @IBOutlet weak var seatNoEight: SeatUIView!
    @IBOutlet weak var seatNoNine: SeatUIView!
    @IBOutlet weak var seatNoTen: SeatUIView!
    @IBOutlet weak var seatNoEleven: SeatUIView!
    @IBOutlet weak var seatNoTwelve: SeatUIView!
    @IBOutlet weak var seatNoThirteen: SeatUIView!
    @IBOutlet weak var seatNoFourteen: SeatUIView!
    @IBOutlet weak var seatNoFifteen: SeatUIView!
    @IBOutlet weak var seatNoSixteen: SeatUIView!
    @IBOutlet weak var seatNoSeventeen: SeatUIView!
    @IBOutlet weak var seatNoEighteen: SeatUIView!
    @IBOutlet weak var seatNoNineteen: SeatUIView!
    @IBOutlet weak var seatNoTwenty: SeatUIView!
    @IBOutlet weak var seatNoTwentyOne: SeatUIView!
    @IBOutlet weak var seatNoTwentyTwo: SeatUIView!
    @IBOutlet weak var seatNoTwentyThree: SeatUIView!
    @IBOutlet weak var seatNoTwentyFour: SeatUIView!
    @IBOutlet weak var seatNoTwentyFive: SeatUIView!
    @IBOutlet weak var seatNoTwentySix: SeatUIView!
    @IBOutlet weak var seatNoTwentySeven: SeatUIView!
    @IBOutlet weak var seatNoTwentyEight: SeatUIView!
    @IBOutlet weak var seatNoTwentyNine: SeatUIView!
    @IBOutlet weak var seatNoThirty: SeatUIView!
    @IBOutlet weak var seatNoThirtyOne: SeatUIView!
    @IBOutlet weak var seatNoThirtyTwo: SeatUIView!
    @IBOutlet weak var seatNoThirtyThree: SeatUIView!
    @IBOutlet weak var seatNoThirtyFour: SeatUIView!
    @IBOutlet weak var seatNoThirtyFive: SeatUIView!
    @IBOutlet weak var seatNoThirtySix: SeatUIView!
    @IBOutlet weak var seatNoThirtySeven: SeatUIView!
    @IBOutlet weak var seatNoThirtyEight: SeatUIView!
    @IBOutlet weak var seatNoThirtyNine: SeatUIView!
    @IBOutlet weak var seatNoForty: SeatUIView!
    @IBOutlet weak var seatNoFortyOne: SeatUIView!
    @IBOutlet weak var seatNoFortyTwo: SeatUIView!
    @IBOutlet weak var seatNoFortyThree: SeatUIView!
    @IBOutlet weak var seatNoFortyFour: SeatUIView!
    @IBOutlet weak var seatNoFortyFive: SeatUIView!
    
    var fromLocation = ""
    var toLocation = ""
    var ticketDate = ""
    var ticketHour = ""
    var estimatedTime = ""
    
    var oneTicketPrice = 0
    var selectedSeatsCount = 0
    var totalTicketPrice = 0
    var selectedSeatNumbers = [Int]()
    var selectedSeatNumbersText = ""
    var busFirm = ""
    
    var bus: BusModel?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        addTapGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    private func retrieveSelectedSeats() -> [String]? {
        let fetchRequest: NSFetchRequest<Ticket> = Ticket.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "fromLocation == %@ AND toLocation == %@ AND busFirm == %@", fromLocation, toLocation, busFirm)
        
        do {
            let tickets = try context.fetch(fetchRequest)
            return tickets.compactMap { $0.seatNo }
        } catch {
            print("Error fetching selected seats: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func updateContinueButton() {
        continueButton.isEnabled = selectedSeatsCount > 0
    }
    
    @objc func continueButtonTapped() {
        let storyboard = UIStoryboard(name: "Payment", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "Payment") as? PaymentTableViewController {
            
            vc.totalAmount = totalTicketPrice
            vc.selectedSeatNumbers = selectedSeatNumbersText
            vc.ticketDate = ticketDate
            vc.ticketHour = ticketHour
            vc.fromLocation = fromLocation
            vc.toLocation = toLocation
            vc.estHour = estimatedTime
            vc.busFirm = busFirm
            
            vc.navigationItem.title = "Fill Your Info"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Failed to instantiate SearchLocationViewController")
        }
    }
    
    private func addTapGestureRecognizers() {
        let seats: [SeatUIView] = [
            seatNoOne, seatNoTwo, seatNoThree, seatNoFour, seatNoFive,
            seatNoSix, seatNoSeven, seatNoEight, seatNoNine, seatNoTen,
            seatNoEleven, seatNoTwelve, seatNoThirteen, seatNoFourteen,
            seatNoFifteen, seatNoSixteen, seatNoSeventeen, seatNoEighteen,
            seatNoNineteen, seatNoTwenty, seatNoTwentyOne, seatNoTwentyTwo,
            seatNoTwentyThree, seatNoTwentyFour, seatNoTwentyFive, seatNoTwentySix,
            seatNoTwentySeven, seatNoTwentyEight, seatNoTwentyNine, seatNoThirty,
            seatNoThirtyOne, seatNoThirtyTwo, seatNoThirtyThree, seatNoThirtyFour,
            seatNoThirtyFive, seatNoThirtySix, seatNoThirtySeven, seatNoThirtyEight,
            seatNoThirtyNine, seatNoForty, seatNoFortyOne, seatNoFortyTwo,
            seatNoFortyThree, seatNoFortyFour, seatNoFortyFive
        ]
        for seat in seats {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSeatTap(_:)))
            seat.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func handleSeatTap(_ gesture: UITapGestureRecognizer) {
        guard let selectedSeat = gesture.view as? SeatUIView else { return }
        
        let seatNumber = selectedSeat.tag
        
        if selectedSeat.isSelected {
            selectedSeat.isSelected = false
            selectedSeatsCount -= 1
            selectedSeatNumbers.removeAll { $0 == seatNumber }
        } else {
            if selectedSeatsCount < 5 {
                selectedSeat.isSelected = true
                selectedSeatsCount += 1
                selectedSeatNumbers.append(seatNumber)
            } else {
                showAlert(message: "You can only select up to 5 seats.")
                return
            }
        }
        updateContinueButton()
        
        selectedSeatNumbersText = selectedSeatNumbers.map { String($0) }.joined(separator: ", ")
        selectedSeatLabel.text = selectedSeatNumbersText
        
        totalTicketPrice = selectedSeatsCount * oneTicketPrice
        totalAmountLabel.text = "\(totalTicketPrice) TL"
        
        if selectedSeatNumbersText == "" && totalTicketPrice == 0 {
            selectedSeatLabel.text = "N/A"
            totalAmountLabel.text = "N/A"
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateUI() {
        fromLocationLabel.text = fromLocation
        toLocationLabel.text = toLocation
        ticketDateLabel.text = ticketDate
        ticketHourLabel.text = ticketHour
        estimatedTimeLabel.text = estimatedTime
        
        if let savedSeats = retrieveSelectedSeats() {
            if !savedSeats.isEmpty {
                var bookedSeats = Set<Int>()
                
                for seatNumbersString in savedSeats {
                    let seatNumbersArray = seatNumbersString.components(separatedBy: ", ")
                    
                    for seatNumberString in seatNumbersArray {
                        if let seatNumber = Int(seatNumberString) {
                            bookedSeats.insert(seatNumber)
                        }
                    }
                }
                
                for seatNumber in bookedSeats {
                    if let seatView = view.viewWithTag(seatNumber) as? SeatUIView {
                        seatView.backgroundColor = .black
                        seatView.isUserInteractionEnabled = false
                    }
                }
            } else {
                print("No saved seats for this route")
            }
        }
    }
}
