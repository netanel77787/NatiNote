//
//  MapViewController.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import UIKit

class MapViewController: UIViewController {
    
    var note: Note?

    @IBOutlet weak var editTitleTextField: UITextField!
    
    @IBOutlet weak var editContentTextField: UITextField!
    
    @IBOutlet weak var editImageView: UIImageView!
    
    @IBAction func saveTapped(_ sender: UIButton) {
        guard let note = note,
              let title = editTitleTextField.text,
              let content = editContentTextField.text,
              let image = editImageView.image
        else {
            return
        }
        
        note.title = title
        note.content = content
//        note.image = Data(data: )

        NotesDAO.shared.update(note: note)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitleTextField.text = note?.title
        editContentTextField.text = note?.content
        // Do any additional setup after loading the view.
    }
    


}
