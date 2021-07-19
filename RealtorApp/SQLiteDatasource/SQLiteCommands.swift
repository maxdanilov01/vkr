//
//  SQLiteCommands.swift
//  RealtorApp
//
//  Created by Максим Данилов on 06.06.2021.
//

import Foundation
import SQLite

class SQLiteCommands {
    static var table = Table ("contact")
    
    static let id = Expression<Int>("id")
    static let firstName = Expression<String>("firstName")
    static let lastName = Expression<String>("lastName")
    static let phoneNumber = Expression<String>("phoneNumber")
    static let oneRoom = Expression<Bool>("oneRoom")
    static let twoRoom = Expression<Bool>("twoRoom")
    static let threeRoom = Expression<Bool>("threeRoom")
    static let fourRoom = Expression<Bool>("fourRoom")
    
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 2")
            return
        }
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(firstName)
                table.column(lastName)
                table.column(phoneNumber)
                table.column(oneRoom)
                table.column(twoRoom)
                table.column(threeRoom)
                table.column(fourRoom)
            })
            
        } catch {
            print("error 3")
        }
    }
    
    static func insertRow(_ contactValues:Contact) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 4")
            return nil
        }
        
        do {
            try database.run(table.insert(firstName <- contactValues.firstName, lastName <- contactValues.lastName, phoneNumber <- contactValues.phoneNumber, oneRoom <- contactValues.oneRoom, twoRoom <- contactValues.twoRoom, threeRoom <- contactValues.threeRoom, fourRoom <- contactValues.fourRoom))
            return true
            
        } catch {
            print("error 5")
            return false
        }
    }
    
    static func updateRow(_ contactValues: Contact) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 6")
            return nil
        }
        let contact = table.filter(id == contactValues.id).limit(1)
        
        do {
            if try database.run(contact.update(firstName <- contactValues.firstName, lastName <- contactValues.lastName, phoneNumber <- contactValues.phoneNumber, oneRoom <- contactValues.oneRoom, twoRoom <- contactValues.twoRoom, threeRoom <- contactValues.threeRoom, fourRoom <- contactValues.fourRoom)) > 0 {
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
    
    static func presentRow() -> [Contact]? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 6")
            return nil
        }
        var contactArray = [Contact]()
        table = table.order(id.desc)
        
        do {
            for contact in try database.prepare(table) {
                let idValue = contact[id]
                let firstNameValue = contact[firstName]
                let lastNameValue = contact[lastName]
                let phoneNumberValue = contact[phoneNumber]
                let oneRoomValue = contact[oneRoom]
                let twoRoomValue = contact[twoRoom]
                let threeRoomValue = contact[threeRoom]
                let fourRoomValue = contact[fourRoom]
                
                let contactObject = Contact(id: idValue, firstName: firstNameValue, lastName: lastNameValue, phoneNumber: phoneNumberValue, oneRoom: oneRoomValue, twoRoom: twoRoomValue, threeRoom: threeRoomValue, fourRoom: fourRoomValue)
                contactArray.append(contactObject)
                
                print(contact[id], contact[firstName], contact[lastName], contact[phoneNumber], contact[oneRoom], contact[twoRoom], contact[threeRoom], contact[fourRoom])
            }
            
        } catch {
            print("error 7")
        }
        return contactArray
    }
    
    static func deleteRow(contactId: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 666")
            return
        }
        do {
            let contact = table.filter(id == contactId).limit(1)
            try database.run(contact.delete())
        } catch {
            print("error 111000")
        }
    }
    
}
