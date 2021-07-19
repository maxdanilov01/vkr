//
//  FlatScreenTableViewController.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import UIKit

class FlatScreenTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    @IBOutlet weak var flatTableView: UITableView!
    
    
    private var viewModel = flatScreenViewModel()
    private var flatArray = [Flat]()
    var filteredFlat = [Flat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Квартиры"
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
        flatArray = FlatCommands.presentRow() ?? []
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //viewModel.numberOfRowsInSection(section: section)
        if (searchController.isActive) {
            return filteredFlat.count
        }
        return flatArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flatCell", for: indexPath)

        //let object = viewModel.cellForRowAt(indexPath: indexPath)
        let object: Flat!
        if (searchController.isActive) {
            object = filteredFlat[indexPath.row]
        }
        else {
            object = flatArray[indexPath.row]
        }
        if let flatCell = cell as? FlatTableViewCell {
            flatCell.setCellWithValuesOf(object)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //let flat = viewModel.cellForRowAt(indexPath: indexPath)
            let flat = flatArray[indexPath.row]
            FlatCommands.deleteRow(flatId: flat.id)
            self.loadData()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editFlat", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editFlat" {
            guard let newFlatVC = segue.destination as? NewFlatViewController
            else {
                return
            }
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedFlat: Flat!
                if(searchController.isActive) {
                    selectedFlat = filteredFlat[indexPath.row]
                } else {
                    selectedFlat = flatArray[indexPath.row]
                }
                newFlatVC.viewModel = NewFlatViewModel(flatValues: selectedFlat)
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
        filteredFlat = flatArray.filter {
            flat in
            let scopeMatch = (scopeButton == "All" || flat.rooms.description.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "") {
                let searchTextMatch = flat.adress.lowercased().contains(searchText.lowercased())
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
            }
        }
        tableView.reloadData()
    }

}
