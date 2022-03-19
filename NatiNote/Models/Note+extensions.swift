//
//  Note+extensions.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import Foundation

extension Note{
    convenience init(title: String, content: String, image: Data? = nil) {
        self.init(context: NotesDAO.shared.context)
        self.title = title
        self.content = content
        self.image = image
    }
}
