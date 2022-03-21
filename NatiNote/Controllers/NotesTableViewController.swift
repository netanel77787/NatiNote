//
//  NotesTableViewController.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import UIKit

class NotesTableViewController: UITableViewController{
    
    let dao = NotesDAO.shared
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signOut()
        notes = dao.loadNotes()
        tableView.reloadData()
   
    }

    @IBAction func addPersonTapped(_ sender: UIBarButtonItem) {
        func noteTapped(alert: UIAlertController){
            let title = alert.textFields?[0].text ?? ""
            let content = alert.textFields?[1].text ?? ""

            if title == "" {
                showError(title: "You must enter title ")
                dao.saveContext()
                return
               
            }
            
            if content == "" {
                showError(title: "You must enter content ")
                dao.saveContext()
                return
               
            }
            
            let note = Note(title: title, content: content)
            
            dao.addNote(note: note)
            
            notes.append(note)
                        
            let path = IndexPath(row: notes.count-1, section: 0)
            
            tableView.insertRows(at: [path], with: .bottom)
            
            tableView.scrollToRow(at: path, at: .bottom, animated: true)
            
        }
        showAlert(callback: noteTapped(alert:))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = notes[indexPath.item]
        
        if let cell = cell as? NoteTableViewCell{
            
            changeCellBackground(cell)

            cell.populate(note: note)
        }
        
        return cell
    }
    
}

extension NotesTableViewController{
    func showAlert(callback: @escaping (UIAlertController)->Void){
        let alert = UIAlertController(title: "Add note",
                                      message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Title"
            textField.keyboardType = .alphabet
        }
        
        alert.addTextField { textField in
            if textField.text != nil{
                textField.placeholder = "Content"
                textField.keyboardType = .alphabet
            }else{
                
            }
            
        }
      
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { action in
                callback(alert)
            })
        )
        
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel, handler: {[weak self] action in
                self?.showLabel(title: "Successfully exit")
            })
        )
        present(alert, animated: true)
        
    }
}

extension NotesTableViewController{
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note = notes[indexPath.row]
        performSegue(withIdentifier: "edit", sender: note)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let dest = segue.destination as? MapViewController,
              let note = sender as? Note
        else {return}
        
        dest.note = note
        dest.delegate = self
    }
   
}

extension NotesTableViewController{
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        notes.append(notes.remove(at: sourceIndexPath.row))
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
                            UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let note = notes[indexPath.item]
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            dao.context.delete(note)
            dao.saveContext()
        }
    }
}

extension NotesTableViewController{
    fileprivate func changeCellBackground(_ cell: NoteTableViewCell) {
        var imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 100, height: 200))
        
        let image = UIImage(named: "nn")
        
        cell.backgroundColor = UIColor.clear
        
        imageView = UIImageView(image:image)
        
        cell.backgroundView = imageView
    }
}

extension NotesTableViewController: MapViewControllerDelegate {
    func didEdit(note: Note) {
        let path = IndexPath(row: notes.firstIndex(of: note) ?? 0, section: 0)
        tableView.reloadRows(at: [path], with: .automatic)
    }
}
