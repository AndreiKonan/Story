//
//  ViewController.swift
//  BirthdatTracker
//
//  Created by Admin on 16.02.23.
//

import UIKit
import CoreData
import UserNotifications
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
            let message = "Сегодня \(firstName) \(lastName) празднует день рождения"
            let content = UNMutableNotificationContent()
            content.body = message
            content.sound = UNNotificationSound.default
            var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthdate)
            dateComponents.hour = 13
            dateComponents.minute = 45
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            if let indentifier = newBirthday.birthdayid {
                let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
            }
        } catch let error{
            print("не удалось сохранить из-за ошики \(error).")
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

