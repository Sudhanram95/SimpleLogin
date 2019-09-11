//
//  RegisterViewController.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, RegisterViewProtocol {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var registerProtocol: RegisterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerProtocol = RegisterPresenter(registerViewProtocol: self)
    }
    
    @IBAction func onCreateNewUser(_ sender: UIButton) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        let alertMessage = registerProtocol?.onValidateRegistrationForm(email: email, name: name, password: password, confirmPassword: confirmPassword)
        
        if alertMessage!.isEmpty {
            registerProtocol?.onCreateNewUser(email: email, name: name, password: password)
        } else {
            showAlert(message: alertMessage!)
        }
    }
    
    func onNewuserCreatedResult(isUserCreated: Bool) {
        if(isUserCreated) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let welcomeViewController = storyBoard.instantiateViewController(withIdentifier: "welcome_view_controller") as! WelcomeViewController
            self.present(welcomeViewController, animated:true, completion:nil)
        } else {
            showAlert(message: "User already exist")
        }
    }
    
    func showAlert(message: String)  {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}

