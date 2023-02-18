//
//  BirthdaysTableViewController.swift
//  BirthdatTracker
//
//  Created by Admin on 16.02.23.
//

import UIKit
import CoreData

class BirthdaysTableViewController: UITableViewController {
    
    
var birthdays = [Birthday]()
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRecwest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
        let sortDescriptor1 = NSSortDescriptor(key: "lastName", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRecwest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        do {
            birthdays = try context.fetch(fetchRecwest)
        }catch let error{
            print("не удалось загрузить данные из-за ошибки: \(error) ")
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return birthdays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCellIdentifier", for: indexPath)
        let birthday = birthdays[indexPath.row]
        let firstName = birthday.firstName ?? " "
        let lastName = birthday.lastName ?? ""
        cell.textLabel?.text = firstName + " " + lastName
        if let date = birthday.birthdate as Date? {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        } else {
            cell.textLabel?.text = " "
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
        if birthdays.count > indexPath.row {
            let birthday = birthdays[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context  = appDelegate.persistentContainer.viewContext
            context.delete(birthday)
            birthdays.remove(at: indexPath.row)
            do {
                try context.save()
            } catch let error{
                print("не удалось сохранить из-за ошики \(error).")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
            
    }
  

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

//    func addBirthdayViewController(_addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday) {
//        birthdays.append(birthday)
//        tableView.reloadData()
//    }
     
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let navigationController = segue.destination as! UINavigationController
//        let addBirthdayViewController = navigationController.topViewController as! AddBirthdayViewController
//            addBirthdayViewController.delegate = self

    }
   

}
