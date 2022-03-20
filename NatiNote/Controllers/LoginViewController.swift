//
//  LoginViewController.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 18/03/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
  
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!


    
    @IBOutlet weak var togglePasswordLabel: UILabel!
    
    @IBAction func showPasswordSwitch(_ sender: UISwitch) {
        passwordTextField.isSecureTextEntry = !sender.isOn
        togglePasswordLabel.text = sender.isOn ? "Hide Password" : "Show Password"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard isEmailValid && isPasswordValid,
              let email = emailTextField.text,
              let password = passwordTextField.text else {return}
        
       showProgress(title: "Signing in please wait")
        
   
        AppAuth.shared.login(email: email, password: password, callback: loginCallback(_:_:))
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.disableAutoFill()
        emailTextField.disableAutoFill()
        // Do any additional setup after loading the view.
    }
    

   

}



extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
