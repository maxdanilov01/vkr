//
//  NewContactViewModel.swift
//  RealtorApp
//
//  Created by Максим Данилов on 06.06.2021.
//

import UIKit

class NewContactViewModel {
    private var contactValues: Contact?
    
    let id: Int?
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    let oneRoom: Bool?
    let twoRoom: Bool?
    let threeRoom: Bool?
    let fourRoom: Bool?
    
    init(contactValues: Contact?) {
        self.contactValues = contactValues
        self.id = contactValues?.id
        self.firstName = contactValues?.firstName
        self.lastName = contactValues?.lastName
        self.phoneNumber = contactValues?.phoneNumber
        self.oneRoom = contactValues?.oneRoom
        self.twoRoom = contactValues?.twoRoom
        self.threeRoom = contactValues?.threeRoom
        self.fourRoom = contactValues?.fourRoom
    }
}
