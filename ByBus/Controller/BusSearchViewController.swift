//
//  BusSearchViewController.swift
//  ByBus
//
//  Created by Güray Gül on 23.04.2024.
//

import UIKit
import CoreData

class BusSearchViewController: UIViewController {
    
    @IBOutlet weak var busSearchCollectionView: UICollectionView!
    @IBOutlet weak var ticketDateLabel: UILabel!
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var busses: [BusModel] = MockData.busses
    
    var fromLocation = ""
    var toLocation = ""
    var ticketDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busSearchCollectionView.delegate = self
        busSearchCollectionView.dataSource = self
        
        ticketDateLabel.text = ticketDate
    }
    
    private func retrieveSelectedSeats(busFirm: String) -> [String]? {
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
}

extension BusSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return busses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = busSearchCollectionView.dequeueReusableCell(withReuseIdentifier: "busSearchCell", for: indexPath) as! BusSearchCollectionViewCell
        let bus = busses[indexPath.row]
        
        var availableSeats = 45
        
        if let savedSeats = retrieveSelectedSeats(busFirm: bus.busFirm) { // Update UI to indicate previously selected seats
            if !savedSeats.isEmpty {
                var bookedSeats = Set<Int>()
                
                for seatNumbersString in savedSeats { // Split the string into individual seat numbers
                    let seatNumbersArray = seatNumbersString.components(separatedBy: ", ")
                    
                    for seatNumberString in seatNumbersArray {
                        if let seatNumber = Int(seatNumberString) {
                            bookedSeats.insert(seatNumber)
                        }
                    }
                    let bookedSeatsCount = bookedSeats.count
                    availableSeats = 45 - bookedSeatsCount
                }
            } else {
                print("No saved seats for this route")
            }
        }
        
        cell.fromLocation.text = fromLocation
        cell.toLocation.text = toLocation
        cell.busImage.image = UIImage(named: bus.busFirmImage)
        cell.busPrice.text = "\(bus.busPrice) TL"
        cell.busTime.text = bus.busTime
        cell.estimatedTime.text = bus.estimatedTime
        cell.seatsLeft.text = "\(availableSeats) left"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SeatSelection", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SeatSelection") as? SeatSelectionViewController {
            let bus = busses[indexPath.row]
            
            vc.bus = bus
            vc.ticketHour = bus.busTime
            vc.estimatedTime = bus.estimatedTime
            vc.oneTicketPrice = bus.busPrice
            vc.busFirm = bus.busFirm
            
            vc.fromLocation = fromLocation
            vc.toLocation = toLocation
            vc.ticketDate = ticketDate
            
            vc.navigationItem.title = "Select Your Seat"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Failed to instantiate SearchLocationViewController")
        }
    }
}

extension BusSearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 2)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }
}
