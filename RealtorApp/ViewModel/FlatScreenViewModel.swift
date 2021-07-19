//
//  FlatScreenViewModel.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import Foundation

class flatScreenViewModel {
    private var flatArray = [Flat]()
    func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    /*func loadDataFromSQLiteDatabase() {
        flatArray = FlatCommands.presentRow() ?? []
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if flatArray.count != 0 {
            return flatArray.count
        }
        return 0
    }
    func cellForRowAt (indexPath: IndexPath) -> Flat {
        return flatArray[indexPath.row]
    }*/
    
}
