//
//  SQLiteDatabase.swift
//  RealtorApp
//
//  Created by Максим Данилов on 06.06.2021.
//

import Foundation
import SQLite

class SQLiteDatabase {
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("contactList").appendingPathExtension("sqlite3")
            database = try Connection(fileUrl.path)
        } catch {
            print("error 1")
        }
    }
    
    func createTable() {
        SQLiteCommands.createTable()
    }
    
    func createFlatTable() {
        FlatCommands.createTable()
    }
    
    func createNoteTable() {
        NoteCommands.createTable()
    }
}
