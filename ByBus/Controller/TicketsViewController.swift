//
//  TicketsViewController.swift
//  ByBus
//
//  Created by Güray Gül on 27.04.2024.
//

import UIKit
import CoreData

class TicketsViewController: UIViewController {
    
    @IBOutlet weak var ticketCollectionView: UICollectionView!
    @IBOutlet var emptyTicketView: UIView!
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    var tickets: [Ticket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ticketCollectionView.delegate = self
        ticketCollectionView.dataSource = self
        ticketCollectionView.backgroundView = emptyTicketView
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let ticketFetchRequest: NSFetchRequest<Ticket> = Ticket.fetchRequest()
        ticketFetchRequest.relationshipKeyPathsForPrefetching = ["customer", "ticketDate", "ticketHour"]
        
        do {
            tickets = try context.fetch(ticketFetchRequest)
            ticketCollectionView.reloadData()
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
}

extension TicketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ticketCollectionView.dequeueReusableCell(withReuseIdentifier: "ticketCell", for: indexPath) as! TicketsCollectionViewCell
        
        ticketCollectionView.backgroundView?.isHidden = tickets.count == 0 ? false : true
        
        let ticket = tickets[indexPath.item]
        
        cell.ticketNameSurname.text = "\(ticket.customer?.name?.capitalized ?? "N/A") \(ticket.customer?.surname?.capitalized ?? "N/A")"
        cell.ticketID.text = ticket.ticketID?.uuidString
        
        if let ticketID = ticket.ticketID {
            let truncatedID = String(ticketID.uuidString.prefix(13))
            cell.ticketID.text = truncatedID
        }
        
        cell.ticketDate.text = ticket.ticketDate?.date
        cell.ticketHour.text = ticket.ticketHour?.hour
        cell.ticketEstHour.text = ticket.ticketHour?.estHour
        
        cell.fromLocation.text = ticket.fromLocation
        cell.toLocation.text = ticket.toLocation
        cell.ticketSeat.text = ticket.seatNo
        cell.ticketPrice.text = "\(ticket.ticketPrice ?? "N/A") TL"
        cell.ticketBusFirm.text = ticket.busFirm
        
        return cell
    }
}

extension TicketsViewController: UICollectionViewDelegateFlowLayout {
    
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
