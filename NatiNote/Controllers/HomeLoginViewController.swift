//
//  HomeLoginViewController.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 18/03/2022.
//

import UIKit

class HomeLoginViewController: UIViewController {

    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
       
        registerLabel.numberOfLines = 2
        registerLabel.lineBreakMode = .byWordWrapping
        registerLabel.text = """
        New to us?
        please sign up
        """
        registerLabel.frame.size.width = 300
        registerLabel.sizeToFit()
        
        loginLabel.numberOfLines = 2
        loginLabel.lineBreakMode = .byWordWrapping
        loginLabel.text = """
        Already have a user?
        go ahead and sign in
        """
        loginLabel.frame.size.width = 300
      
        loginLabel.sizeToFit()
        
      
        
        self.view.backgroundColor = UIColor(patternImage: (UIImage(named: "nn") ?? UIImage(named: "systemImage"))!)
        
    }
    



}
