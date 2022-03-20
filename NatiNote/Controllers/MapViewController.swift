//
//  MapViewController.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import UIKit

class MapViewController: UIViewController {
    
    var delegate: MapViewControllerDelegate?
    
    var note: Note?

    @IBOutlet weak var editTitleTextField: UITextField!
    
    @IBOutlet weak var editContentTextField: UITextField!
    
  
    
    @IBAction func saveTapped(_ sender: UIButton) {
      
        
        guard let note = note,
              let title = editTitleTextField.text,
              let content = editContentTextField.text
              
        else {
            return
        }
        
        note.title = title
        note.content = content


        NotesDAO.shared.update(note: note)
        navigationController?.popViewController(animated: true)
        
        delegate?.didEdit(note: note)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitleTextField.text = note?.title
        editContentTextField.text = note?.content
        
        self.view.backgroundColor = UIColor(patternImage: (UIImage(named: "nn") ?? UIImage(named: "systemImage"))!)
    }
    


}

protocol MapViewControllerDelegate{
    func didEdit(note: Note)
}
