//
//  LoginViewController.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginProtocol: LoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginProtocol = LoginPresenter(loginViewProtocol: self)
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        print("LOGIN TAPPED:::::::")
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let alertMessage = loginProtocol?.onValidateLogin(email: email, password: password)
        
        if alertMessage!.isEmpty {
            loginProtocol?.checkUserAvailability(email: email, password: password)
        } else {
            showAlert(message: alertMessage!)
        }
    }
    
    func onUserCheckAvailabilityResult(isAvailable: Bool) {
        print("COntroller result::::\(isAvailable)")
        if(isAvailable) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let welcomeViewController = storyBoard.instantiateViewController(withIdentifier: "welcome_view_controller") as! WelcomeViewController
            self.present(welcomeViewController, animated:true, completion:nil)
        } else {
            showAlert(message: "User does not exist")
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
