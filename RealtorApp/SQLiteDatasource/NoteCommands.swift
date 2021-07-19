//
//  NoteCommands.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import Foundation
import SQLite

class NoteCommands {
    static var table = Table ("note")
    
    static let id = Expression<Int>("id")
    static let importance = Expression<String>("importance")
    static let noteText = Expression<String>("noteText")
    
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 2")
            return
        }
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(importance)
                table.column(noteText)
            })
            
        } catch {
            print("error 3")
        }
    }
    
    static func insertRow(_ noteValues:Note) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 4")
            return nil
        }
        
        do {
            try database.run(table.insert(importance <- noteValues.importance, noteText <- noteValues.noteText))
            return true
            
        } catch {
            print("error 5")
            return false
        }
    }
    
    static func updateRow(_ noteValues: Note) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 6")
            return nil
        }
        let note = table.filter(id == noteValues.id).limit(1)
        
        do {
            if try database.run(note.update(importance <- noteValues.importance, noteText <- noteValues.noteText)) > 0 {
                print("Update")
                return true
            } else {
                print("error 228")
                return false
            }
            
        } catch {
            print("error 322")
            return false
        }
    }
    
    static func presentRow() -> [Note]? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 6")
            return nil
        }
        var noteArray = [Note]()
        table = table.order(id.desc)
        
        do {
            for note in try database.prepare(table) {
                let idValue = note[id]
                let importanceValue = note[importance]
                let noteTextValue = note[noteText]
                
                let noteObject = Note(id: idValue, importance: importanceValue, noteText: noteTextValue)
                noteArray.append(noteObject)
                
                print(note[id], note[importance], note[noteText])
            }
            
        } catch {
            print("error 7")
        }
        return noteArray
    }
    
    static func deleteRow(noteId: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 666")
            return
        }
        do {
            let note = table.filter(id == noteId).limit(1)
            try database.run(note.delete())
        } catch {
            print("error 111000")
        }
    }
    
}
