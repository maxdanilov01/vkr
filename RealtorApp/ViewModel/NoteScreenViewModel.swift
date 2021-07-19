//
//  NoteScreenViewModel.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import Foundation

class noteScreenViewModel {
    private var noteArray = [Note]()
    func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    /*func loadDataFromSQLiteDatabase() {
        noteArray = NoteCommands.presentRow() ?? []
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if noteArray.count != 0 {
            return noteArray.count
        }
        return 0
    }
    func cellForRowAt (indexPath: IndexPath) -> Note {
        return noteArray[indexPath.row]
    }*/
    
}
