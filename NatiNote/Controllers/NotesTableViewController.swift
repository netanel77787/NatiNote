//
//  NotesTableViewController.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import UIKit

class NotesTableViewController: UITableViewController {

    let dao = NotesDAO.shared
    var notes: [Note] = []
    
   
    @IBAction func addPersonTapped(_ sender: UIBarButtonItem) {
        func noteTapped(alert: UIAlertController){
            let title = alert.textFields?[0].text ?? ""
            let content = alert.textFields?[1].text ?? ""
            
            let note = Note(title: title, content: content)
            
            dao.addNote(note: note)
            
            notes.append(note)
            let path = IndexPath(row: notes.count-1, section: 0)
            
            tableView.insertRows(at: [path], with: .automatic)
            
            tableView.scrollToRow(at: path, at: .bottom, animated: true)
        }
       
        showAlert(callback: noteTapped(alert:))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notes = dao.loadNotes()
        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        performSegue(withIdentifier: "edit", sender: note)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? MapViewController,
              let note = sender as? Note
        else {return}
        dest.note = note
    }
  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = notes[indexPath.item]
        
        if let cell = cell as? NoteTableViewCell{
            cell.populate(note: note)
        }
        
        return cell
    }

}


extension NotesTableViewController{
    func showAlert(callback: @escaping (UIAlertController)->Void){
    let alert = UIAlertController(title: "Add note",
                                  message: "message", preferredStyle: .alert)
    
    alert.addTextField { textField in
        textField.placeholder = "Title"
        textField.keyboardType = .alphabet
    }
    
    alert.addTextField { textField in
        textField.placeholder = "Content"
        textField.keyboardType = .alphabet
    }
    
    
    
    alert.addAction(
        UIAlertAction(title: "OK", style: .default, handler: { action in
            callback(alert)
        })
    )
    
        
    alert.addAction(
        UIAlertAction(title: "cancel", style: .cancel, handler: { action in
            print("cancel tapped")
        })
    )
    
    present(alert, animated: true)
    

    }
}




//extension NotesTableViewController{
//    
//    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//    
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        true
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        people.append(people.remove(at: sourceIndexPath.row))
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle:
//                   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == .delete{
//
//            people.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
//}
