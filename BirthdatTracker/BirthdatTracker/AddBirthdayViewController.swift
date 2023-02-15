//
//  ViewController.swift
//  BirthdatTracker
//
//  Created by Admin on 16.02.23.
//

import UIKit

class AddBirthdayViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        birthdatePicker.maximumDate = Date()
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let firstName = NameTextField.text ?? " "
        let lastName = LastNameTextField.text ?? " "
        let birthdate = birthdatePicker.date
        let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthdate: birthdate)
        
        print("Создана новая дата рождения")
        print("Имя \(newBirthday.firstName)")
        print("Фамилия \(newBirthday.lastName)")
        print("День рождения \(newBirthday.birthdate)")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

