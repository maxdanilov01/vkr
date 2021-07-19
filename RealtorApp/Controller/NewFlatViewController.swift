//
//  NewFlatViewController.swift
//  RealtorApp
//
//  Created by Максим Данилов on 09.06.2021.
//

import UIKit

import UIKit

class NewFlatViewController: UIViewController {
    
    

    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var roomsTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    var viewModel: NewFlatViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        setUpViews()
    }
    
    private func createTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createFlatTable()
    }
    
    private func setUpViews() {
        if let viewModel = viewModel {
            adressTextField.text = viewModel.adress
            floorTextField.text = viewModel.floor?.description
            roomsTextField.text = viewModel.rooms?.description
            sizeTextField.text = viewModel.size?.description
            priceTextField.text = viewModel.price?.description
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let id: Int = viewModel == nil ? 0 : viewModel.id!
        let adress = adressTextField.text ?? ""
        let floor = Int(floorTextField.text!) ?? 0
        let rooms = Int(roomsTextField.text!) ?? 0
        let size = Int(sizeTextField.text!) ?? 0
        let price = Int(priceTextField.text!) ?? 0
        
        let flatValues = Flat(id: id, adress: adress, floor: floor, rooms: rooms, size: size, price: price)
        
        
        if viewModel == nil {
            createNewFlat(flatValues)
            
        } else {
            updateFlat(flatValues)
        }
    }
    
    private  func createNewFlat(_ flatValues:Flat) {
        let flatAddedToTable = FlatCommands.insertRow(flatValues)
        if flatAddedToTable == true {
            dismiss(animated: true, completion: nil)
        } else {
            print("error 11")
        }
        
        
    }
    
    private func updateFlat(_ flatValues: Flat) {
        let flatUpdatedInTable = FlatCommands.updateRow(flatValues)
        if flatUpdatedInTable == true {
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
