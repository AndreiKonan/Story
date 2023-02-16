//
//  ViewController.swift
//  BirthdatTracker
//
//  Created by Admin on 16.02.23.
//

import UIKit
protocol AddBirthdayViewControllerDelegate{
    func addBirthdayViewController(_addBirthdayViewController:AddBirthdayViewController, didAddBirthday birthday:Birthday)
}

class AddBirthdayViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    var delegate: AddBirthdayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthdatePicker.maximumDate = Date()
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let firstName = NameTextField.text ?? " "
        let lastName = LastNameTextField.text ?? " "
        let birthdate = birthdatePicker.date
        let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthdate: birthdate)
        
       delegate?.addBirthdayViewController(_addBirthdayViewController: self, didAddBirthday: newBirthday)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

