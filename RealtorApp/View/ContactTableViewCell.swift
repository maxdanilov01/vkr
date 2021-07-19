//
//  ContactTableViewCell.swift
//  RealtorApp
//
//  Created by Максим Данилов on 06.06.2021.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var contactFirstNameLabel: UILabel!
    @IBOutlet weak var contactLastNameLabel: UILabel!
    @IBOutlet weak var contactPhoneNumberLabel: UILabel!
    @IBOutlet weak var contactOneRoomLabel: UILabel!
    @IBOutlet weak var contactTwoRoomLabel: UILabel!
    @IBOutlet weak var contactThreeRoomLabel: UILabel!
    @IBOutlet weak var contactFourRoomLabel: UILabel!
    func setCellWithValuesOf(_ contact:Contact){
        
        contactFirstNameLabel.text = contact.firstName
        contactLastNameLabel.text = contact.lastName
        contactPhoneNumberLabel.text = contact.phoneNumber
        if contact.oneRoom.description=="true" {
            contactOneRoomLabel.isEnabled = true
            contactOneRoomLabel.text = "yes"
        } else {
            contactOneRoomLabel.isEnabled = false
            contactOneRoomLabel.text = "not"
        }
        
        if contact.twoRoom.description=="true" {
            contactTwoRoomLabel.isEnabled = true
            contactTwoRoomLabel.text = "yes"
        } else {
            contactTwoRoomLabel.isEnabled = false
            contactTwoRoomLabel.text = "not"
        }
        
        if contact.threeRoom.description=="true" {
            contactThreeRoomLabel.isEnabled = true
            contactThreeRoomLabel.text = "yes"
        } else {
            contactThreeRoomLabel.isEnabled = false
            contactThreeRoomLabel.text = "not"
        }
        
        if contact.fourRoom.description=="true" {
            contactFourRoomLabel.isEnabled = true
            contactFourRoomLabel.text = "yes"
        } else {
            contactFourRoomLabel.isEnabled = false
            contactFourRoomLabel.text = "not"
        }
        
    }

}
