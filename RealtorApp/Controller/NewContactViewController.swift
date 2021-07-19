//
//  NewContactViewController.swift
//  RealtorApp
//
//  Created by Максим Данилов on 06.06.2021.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNunberTextField: UITextField!
    @IBOutlet weak var oneRoomSwitchField: UISwitch!
    @IBOutlet weak var twoRoomSwitchField: UISwitch!
    @IBOutlet weak var threeRoomSwitchField: UISwitch!
    @IBOutlet weak var fourRoomSwitchField: UISwitch!
    
    var viewModel: NewContactViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        setUpViews()
    }
    
    private func createTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
    }
    
    private func setUpViews() {
        if let viewModel = viewModel {
            firstNameTextField.text = viewModel.firstName
            lastNameTextField.text = viewModel.lastName
            phoneNunberTextField.text = viewModel.phoneNumber
            oneRoomSwitchField.isOn = viewModel.oneRoom ?? true
            twoRoomSwitchField.isOn = viewModel.twoRoom ?? true
            threeRoomSwitchField.isOn = viewModel.threeRoom ?? true
            fourRoomSwitchField.isOn = viewModel.fourRoom ?? true
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let id: Int = viewModel == nil ? 0 : viewModel.id!
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = phoneNunberTextField.text ?? ""
        let oneRoom = oneRoomSwitchField.isOn
        let twoRoom = twoRoomSwitchField.isOn
        let threeRoom = threeRoomSwitchField.isOn
        let fourRoom = fourRoomSwitchField.isOn
        
        let contactValues = Contact(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, oneRoom: oneRoom, twoRoom: twoRoom, threeRoom: threeRoom, fourRoom: fourRoom)
        
        
        if viewModel == nil {
            createNewContact(contactValues)
            
        } else {
            updateContact(contactValues)
        }

    }
    
    private  func createNewContact(_ contactValues:Contact) {
        let contactAddedToTable = SQLiteCommands.insertRow(contactValues)
        if contactAddedToTable == true {
            dismiss(animated: true, completion: nil)
        } else {
            print("error 11")
        }
        
        
    }
    
    private func updateContact(_ contactValues: Contact) {
        let contactUpdatedInTable = SQLiteCommands.updateRow(contactValues)
        if contactUpdatedInTable == true {
            if let cellClicked = navigationController {
                cellClicked.popViewController(animated: true)
            }
        } else {
            print("error 111")
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        let addButtonClicked = presentingViewController is UINavigationController
        if addButtonClicked {
            dismiss(animated: true, completion: nil)
        }
        else if let cellClicked = navigationController {
            cellClicked.popViewController(animated: true)
        } else {
            print("error 222")
        }
    }
    
    


}

