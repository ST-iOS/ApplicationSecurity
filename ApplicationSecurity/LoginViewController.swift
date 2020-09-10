//
//  ViewController.swift
//  ApplicationSecurity
//
//  Created by subash on 9/1/20.
//  Copyright © 2020 symbolicTrace. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    let usernameKey = "subash"
    let passwordKey = "thapa"
    
    var passwordItems: [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    @IBAction func signInAction(_ sender: Any) {
        guard let username = userNameTextField.text, let password = passwordTextField.text else {
            showErrorAlert()
            return
        }
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if checkLogin(username: username, password: password) {
          performSegue(withIdentifier: "dismissLogin", sender: self)
        } else {
            showErrorAlert()
        }
    }
    @IBAction func signUpAction(_ sender: Any) {
        
        
    }
    
    func checkLogin(username: String, password: String) -> Bool {
      return username == usernameKey && password == passwordKey
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Login Failed", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }

}

