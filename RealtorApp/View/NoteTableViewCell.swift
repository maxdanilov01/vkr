//
//  NoteTableViewCell.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var importanceTextLabel: UILabel!
    @IBOutlet weak var noteTextTextView: UITextView!
    

    func setCellWithValuesOf(_ note:Note){
        
        importanceTextLabel.text = note.importance
        noteTextTextView.text = note.noteText
        
        
    }

}
