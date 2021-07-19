//
//  FlatTableViewCell.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import UIKit

class FlatTableViewCell: UITableViewCell {

    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var floatLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    func setCellWithValuesOf(_ flat:Flat){
        
        roomsLabel.text = flat.rooms.description + " к"
        adressLabel.text = flat.adress
        let edn = flat.price % 1000
        var ednstr = edn.description
        if edn == 0 {ednstr="000"}
        let tys = (flat.price / 1000) % 1000
        var tysstr = tys.description
        if tys == 0 {tysstr="000"}
        let mln = flat.price / 1000000
        priceLabel.text = mln.description + "." + tysstr + "." + ednstr + " руб."
        floatLabel.text = flat.floor.description + " этаж"
        sizeLabel.text = flat.size.description + " m2"
        
        
    }


}
