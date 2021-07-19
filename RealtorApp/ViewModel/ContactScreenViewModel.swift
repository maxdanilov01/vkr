//
//  ContactScreenViewModel.swift
//  RealtorApp
//
//  Created by Максим Данилов on 06.06.2021.
//

import Foundation

class contactScreenViewModel {
    private var contactArray = [Contact]()
    func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    func loadDataFromSQLiteDatabase() {
        contactArray = SQLiteCommands.presentRow() ?? []
    }
    
    func presentDataFromSQLiteDatabase() -> [Contact]? {
        contactArray = SQLiteCommands.presentRow() ?? []
        return contactArray
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if contactArray.count != 0 {
            return contactArray.count
        }
        return 0
    }
    func cellForRowAt (indexPath: IndexPath) -> Contact {
        return contactArray[indexPath.row]
    }
    
}
