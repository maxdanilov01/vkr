//
//  NewFlatViewModel.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import UIKit

class NewFlatViewModel {
    private var flatValues: Flat?
    
    let id: Int?
    let adress: String?
    let floor: Int?
    let rooms: Int?
    let size: Int?
    let price: Int?
    
    init(flatValues: Flat?) {
        self.flatValues = flatValues
        self.id = flatValues?.id
        self.adress = flatValues?.adress
        self.floor = flatValues?.floor
        self.rooms = flatValues?.rooms
        self.size = flatValues?.size
        self.price = flatValues?.price
    }
}
