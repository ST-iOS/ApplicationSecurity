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
            showError()
            return
        }
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if checkLogin(username: username, password: password) {
          performSegue(withIdentifier: "dismissLogin", sender: self)
        } else {
            showError()
        }
    }
    
    func checkLogin(username: String, password: String) -> Bool {
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                           account: username,
                                                           accessGroup: KeychainConfiguration.accessGroup)
        guard let keychainPassword = try? passwordItem.readPassword() else {
            return false
        }
        return password == keychainPassword
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let username = userNameTextField.text, let password = passwordTextField.text else {
            showError()
            return
        }
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                account:username,
                                                accessGroup: KeychainConfiguration.accessGroup)
        do {
            try passwordItem.savePassword(password)
            showAlert(title: "Success", message: "Sign up successful")
            
        } catch {
            fatalError("Error updating keychain")
        }
    }
    
    
    func showAlert(title:String, message: String) {
        let alertController = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    func showError() {
          showAlert(title: "Error", message: "Failed")
      }
      
    

}

