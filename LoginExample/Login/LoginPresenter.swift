//
//  LoginPresenter.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import Foundation

class LoginPresenter: LoginProtocol {
    
    let dbConnectivity = DatabaseManager()
    var loginViewProtocol: LoginViewProtocol?
    
    init(loginViewProtocol: LoginViewProtocol) {
        self.loginViewProtocol = loginViewProtocol
        dbConnectivity.createUserTable()
    }
    
    func onValidateLogin(email: String, password: String) -> String {
        var validationResult = ""
        if(email.isEmpty || password.isEmpty) {
            validationResult = "No field must be empty"
        } else if(!validateEmail(enteredEmail: email)) {
            validationResult = "Email is invalid"
        }
        
        return validationResult
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func checkUserAvailability(email: String, password: String) {
        let isUserAvailable = dbConnectivity.isUserAvailable(email: email, password: password)
        loginViewProtocol?.onUserCheckAvailabilityResult(isAvailable: isUserAvailable)
    }
}
