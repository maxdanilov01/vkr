//
//  ContactScreenTableViewController.swift
//  RealtorApp
//
//  Created by Максим Данилов on 06.06.2021.
//

import UIKit

class ContactScreenTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    @IBOutlet var contactTableView: UITableView!
    
    
    private var viewModel = contactScreenViewModel()
    private var contactArray = [Contact]()
    var filteredContact = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Клиенты"
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
        searchController.searchBar.scopeButtonTitles = ["All", "1", "2", "3", "4"]
        searchController.searchBar.delegate = self
    }
    
    private func loadData(){
        contactArray = SQLiteCommands.presentRow() ?? []
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //viewModel.numberOfRowsInSection(section: section)
        if (searchController.isActive) {
            return filteredContact.count
        }
        return contactArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        //let object = viewModel.cellForRowAt(indexPath: indexPath)
        let object: Contact!
        if (searchController.isActive) {
            object = filteredContact[indexPath.row]
        }
        else {
            object = contactArray[indexPath.row]
        }
        if let contactCell = cell as? ContactTableViewCell {
            contactCell.setCellWithValuesOf(object)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //let contact = viewModel.cellForRowAt(indexPath: indexPath)
            let contact = contactArray[indexPath.row]
            SQLiteCommands.deleteRow(contactId: contact.id)
            self.loadData()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editContact", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            guard let newContactVC = segue.destination as? NewContactViewController
            else {
                return
            }
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedContact: Contact!
                if(searchController.isActive) {
                    selectedContact = filteredContact[indexPath.row]
                } else {
                    selectedContact = contactArray[indexPath.row]
                }
                newContactVC.viewModel = NewContactViewModel(contactValues: selectedContact)
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
        filteredContact = contactArray.filter {
            contact in
            var scopeWord = ""
            if contact.oneRoom.description == "true" {scopeWord = scopeWord + "1"}
            if contact.twoRoom.description == "true" {scopeWord = scopeWord + "2"}
            if contact.threeRoom.description == "true" {scopeWord = scopeWord + "3"}
            if contact.fourRoom.description == "true" {scopeWord = scopeWord + "4"}
            let scopeMatch = (scopeButton == "All" || scopeWord.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "") {
                let searchTextMatch = contact.firstName.lowercased().contains(searchText.lowercased())
                let searchSecondTextMatch = contact.lastName.lowercased().contains(searchText.lowercased())
                return scopeMatch && (searchTextMatch || searchSecondTextMatch)
            } else {
                return scopeMatch
            }
        }
        tableView.reloadData()
    }

}
