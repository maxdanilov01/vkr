//
//  NewNoteViewModel.swift
//  RealtorApp
//
//  Created by Максим Данилов on 08.06.2021.
//

import UIKit

class NewNoteViewModel {
    private var noteValues: Note?
    
    let id: Int?
    let importance: String?
    let noteText: String?
    
    init(noteValues: Note?) {
        self.noteValues = noteValues
        self.id = noteValues?.id
        self.importance = noteValues?.importance
        self.noteText = noteValues?.noteText
    }
}
