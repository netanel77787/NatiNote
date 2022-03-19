//
//  NoteTableViewCell.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import UIKit
import SDWebImage

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    

    @IBOutlet weak var myImageView: UIImageView!
    
    func populate(note: Note){
        titleLabel.text = note.title
        contentLabel.text = note.content
        
//        myImageView.sd_setImage(with: UIImage(note.image),
//                          placeholderImage: UIImage(systemName: "photo"))
    }
    
}
