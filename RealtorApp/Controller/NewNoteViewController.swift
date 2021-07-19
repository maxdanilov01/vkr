//
//  NewNoteViewController.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var importanceSegment: UISegmentedControl!
    @IBOutlet weak var noteTextView: UITextView!
    
    var viewModel: NewNoteViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        setUpViews()
        noteTextView.layer.borderWidth = 2
        noteTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private func createTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createNoteTable()
    }
    
    private func setUpViews() {
        if let viewModel = viewModel {
            
            if viewModel.importance == "Высокая" {
                importanceSegment.selectedSegmentIndex = 0
            }
            if viewModel.importance == "Средняя" {
                importanceSegment.selectedSegmentIndex = 1
            }
            if viewModel.importance == "Низкая " {
                importanceSegment.selectedSegmentIndex = 2
            }
            
            noteTextView.text = viewModel.noteText
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let id: Int = viewModel == nil ? 0 : viewModel.id!
        let importance = importanceSegment.selectedSegmentIndex
        let noteText = noteTextView.text ?? ""
        var importanceStr = "test"
        if importance == 0 {importanceStr = "Высокая"}
        if importance == 1 {importanceStr = "Средняя"}
        if importance == 2 {importanceStr = "Низкая "}
        
        let noteValues = Note(id: id, importance: importanceStr, noteText: noteText)
        
        
        if viewModel == nil {
            createNewNote(noteValues)
            
        } else {
            updateNote(noteValues)
        }
    }
    
    private  func createNewNote(_ noteValues:Note) {
        let noteAddedToTable = NoteCommands.insertRow(noteValues)
        if noteAddedToTable == true {
            dismiss(animated: true, completion: nil)
        } else {
            print("error 11")
        }
        
        
    }
    
    private func updateNote(_ noteValues: Note) {
        let noteUpdatedInTable = NoteCommands.updateRow(noteValues)
        if noteUpdatedInTable == true {
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
