//
//  FlatCommands.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import Foundation
import SQLite

class FlatCommands {
    static var table = Table ("flat")
    
    static let id = Expression<Int>("id")
    static let adress = Expression<String>("adress")
    static let floor = Expression<Int>("floor")
    static let rooms = Expression<Int>("rooms")
    static let size = Expression<Int>("size")
    static let price = Expression<Int>("price")
    
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 2")
            return
        }
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(adress)
                table.column(floor)
                table.column(rooms)
                table.column(size)
                table.column(price)
            })
            
        } catch {
            print("error 3")
        }
    }
    
    static func insertRow(_ flatValues:Flat) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 4")
            return nil
        }
        
        do {
            try database.run(table.insert(adress <- flatValues.adress, floor <- flatValues.floor, rooms <- flatValues.rooms, size <- flatValues.size, price <- flatValues.price))
            return true
            
        } catch {
            print("error 5")
            return false
        }
    }
    
    static func updateRow(_ flatValues: Flat) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 6")
            return nil
        }
        let flat = table.filter(id == flatValues.id).limit(1)
        
        do {
            if try database.run(flat.update(adress <- flatValues.adress, floor <- flatValues.floor, rooms <- flatValues.rooms, size <- flatValues.size, price <- flatValues.price)) > 0 {
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
    
    static func presentRow() -> [Flat]? {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 6")
            return nil
        }
        var flatArray = [Flat]()
        table = table.order(id.desc)
        
        do {
            for flat in try database.prepare(table) {
                let idValue = flat[id]
                let adressValue = flat[adress]
                let floorValue = flat[floor]
                let roomsValue = flat[rooms]
                let sizeValue = flat[size]
                let priceValue = flat[price]
                
                let flatObject = Flat(id: idValue, adress: adressValue, floor: floorValue, rooms: roomsValue, size: sizeValue, price: priceValue)
                flatArray.append(flatObject)
                
                print(flat[id], flat[adress], flat[floor], flat[rooms], flat[size], flat[price])
            }
            
        } catch {
            print("error 7")
        }
        return flatArray
    }
    
    static func deleteRow(flatId: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database
        else {
            print("error 666")
            return
        }
        do {
            let flat = table.filter(id == flatId).limit(1)
            try database.run(flat.delete())
        } catch {
            print("error 111000")
        }
    }
    
}
