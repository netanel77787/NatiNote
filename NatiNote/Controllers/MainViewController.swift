//
//  MainViewController.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        signOut()
        
        let action = UIAction { _ in
              AppAuth.shared.signOut()
          }

          let signOutBBI =  UIBarButtonItem(title: "Sign Out", image: nil, primaryAction: action, menu: .none)
        navigationItem.rightBarButtonItem = signOutBBI
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
