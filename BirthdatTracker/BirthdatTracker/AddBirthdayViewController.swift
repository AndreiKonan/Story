//
//  ViewController.swift
//  BirthdatTracker
//
//  Created by Admin on 16.02.23.
//

import UIKit
import CoreData
//protocol AddBirthdayViewControllerDelegate{
//    func addBirthdayViewController(_addBirthdayViewController:AddBirthdayViewController, didAddBirthday birthday:Birthday)
//}

class AddBirthdayViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
//    var delegate: AddBirthdayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthdatePicker.maximumDate = Date()
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let firstName = NameTextField.text ?? " "
        let lastName = LastNameTextField.text ?? " "
        let birthdate = birthdatePicker.date
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdate = birthdate 
        newBirthday.birthdayid = UUID().uuidString
        if let uniqueID = newBirthday.birthdayid {
            print("birthdayID:\(uniqueID)")
        }
        do {
            try context.save()
        } catch let error{
            print("не удалось сохранить из-за ошики \(error).")
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

