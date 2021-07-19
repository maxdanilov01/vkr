//
//  NoteScreenTableViewController.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import UIKit

class NoteScreenTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    @IBOutlet weak var noteTableView: UITableView!
    

    private var viewModel = noteScreenViewModel()
    private var noteArray = [Note]()
    var filteredNote = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Заметки"
        viewModel.connectToDatabase()
        initSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        tableView.reloadData()
    }
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
                
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Высокая", "Средняя", "Низкая"]
        searchController.searchBar.delegate = self
    }
    
    private func loadData(){
        noteArray = NoteCommands.presentRow() ?? []
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //viewModel.numberOfRowsInSection(section: section)
        if (searchController.isActive) {
            return filteredNote.count
        }
        return noteArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        //let object = viewModel.cellForRowAt(indexPath: indexPath)
        let object: Note!
        if (searchController.isActive) {
            object = filteredNote[indexPath.row]
        }
        else {
            object = noteArray[indexPath.row]
        }
        if let noteCell = cell as? NoteTableViewCell {
            noteCell.setCellWithValuesOf(object)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //let note = viewModel.cellForRowAt(indexPath: indexPath)
            let note = noteArray[indexPath.row]
            NoteCommands.deleteRow(noteId: note.id)
            self.loadData()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: "editNote", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            guard let newNoteVC = segue.destination as? NewNoteViewController
            else {
                return
            }
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedNote: Note!
                if(searchController.isActive) {
                    selectedNote = filteredNote[indexPath.row]
                } else {
                    selectedNote = noteArray[indexPath.row]
                }
                newNoteVC.viewModel = NewNoteViewModel(noteValues: selectedNote)
            }
            
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All"){
        filteredNote = noteArray.filter {
            note in
            let scopeMatch = (scopeButton == "All" || note.importance.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "") {
                let searchTextMatch = note.noteText.lowercased().contains(searchText.lowercased())
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
            }
        }
        tableView.reloadData()
    }

}
    

    
    
