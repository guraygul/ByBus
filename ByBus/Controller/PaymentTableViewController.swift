//
//  PaymentTableViewController.swift
//  ByBus
//
//  Created by Güray Gül on 27.04.2024.
//

import UIKit
import CoreData

class PaymentTableViewController: UITableViewController {
    
    @IBOutlet weak var selectedSeatLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    var selectedSeatNumbers = ""
    var totalAmount = 0
    var ticketDate = ""
    var ticketHour = ""
    var fromLocation = ""
    var toLocation = ""
    var estHour = ""
    var busFirm = ""
    
    var ticketID: UUID?
    var customerName = ""
    var customerSurname = ""
    var customerID = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var surnameTextField: RoundedTextField! {
        didSet {
            surnameTextField.tag = 2
            surnameTextField.delegate = self
        }
    }
    
    @IBOutlet var identityTextField: RoundedTextField! {
        didSet {
            identityTextField.tag = 3
            identityTextField.delegate = self
            identityTextField.keyboardType = .numberPad
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
            phoneTextField.keyboardType = .numberPad
        }
    }
    @IBOutlet var emailTextView: RoundedTextField! {
        didSet {
            emailTextView.tag = 5
            emailTextView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        updatePayButtonState()
        updateUI()
    }
    
    private func updatePayButtonState() {
        payButton.isEnabled = isInputComplete()
    }
    
    private func isInputComplete() -> Bool {
        let isNameValid = !(nameTextField.text?.isEmpty ?? true)
        let isSurnameValid = !(surnameTextField.text?.isEmpty ?? true)
        let isIdentityValid = identityTextField.text?.count == 11
        let isPhoneValid = phoneTextField.text?.count == 11
        let isEmailValid = !(emailTextView.text?.isEmpty ?? true)
        
        return isNameValid && isSurnameValid && isIdentityValid && isPhoneValid && isEmailValid
    }
    
    private func updateUI() {
        selectedSeatLabel.text = selectedSeatNumbers
        totalAmountLabel.text = String(totalAmount)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func payButtonTapped(sender: UIButton) {
        if isInputComplete() {
            let alertController = UIAlertController(title: "Confirm Purchase", message: "Are you sure you want to proceed with the payment?", preferredStyle: .alert)
            
            let payAction = UIAlertAction(title: "Pay", style: .default) { _ in
                self.performPayment()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(payAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        ticketID = UUID()
        customerName = nameTextField.text ?? "N/A"
        customerSurname = surnameTextField.text ?? "N/A"
        customerID = identityTextField.text ?? "N/A"
        
        let ticket = Ticket(context: context)
        ticket.ticketID = ticketID
        ticket.fromLocation = fromLocation
        ticket.toLocation = toLocation
        ticket.seatNo = selectedSeatNumbers
        ticket.ticketPrice = String(totalAmount)
        ticket.busFirm = busFirm
        
        let person = Person(context: context)
        person.id = identityTextField.text
        person.name = nameTextField.text
        person.surname = surnameTextField.text
        person.ticket = ticket
        
        let date = Date(context: context)
        date.date = ticketDate
        date.ticket = ticket
        
        let hour = Hour(context: context)
        hour.hour = ticketHour
        hour.estHour = estHour
        hour.ticket = ticket
        
        do {
            try context.save()
            print("Saved data to context successfully...")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    private func performPayment() {
        let storyboard = UIStoryboard(name: "PaymentSuccesful", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccesful") as? PaymentSuccesfulViewController {
            
            vc.fromLocationText = fromLocation
            vc.toLocationText = toLocation
            vc.busFirmText = busFirm
            vc.ticketIDText = ticketID?.uuidString.prefix(13).description ?? "N/A"
            
            vc.ticketDateText = ticketDate
            vc.ticketPriceText = totalAmount
            
            vc.customerName = customerName
            vc.customerSurname = customerSurname
            vc.customerID = customerID
            
            vc.ticketTimeText = ticketHour
            vc.seatNo = selectedSeatNumbers
            
            vc.navigationItem.title = "Ticket Information"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Failed to instantiate PaymentSuccesfulViewController")
        }
    }
}

extension PaymentTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Delay the update slightly to allow the text field to update its text
            self.updatePayButtonState()
        }
        
        if textField == nameTextField || textField == surnameTextField {
            let characterSet = CharacterSet.letters.union(CharacterSet.whitespaces)
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return newText.rangeOfCharacter(from: characterSet.inverted) == nil
            
        } else if textField == identityTextField || textField == phoneTextField {
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 11 && newText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
            
        }
        return true
    }
}

