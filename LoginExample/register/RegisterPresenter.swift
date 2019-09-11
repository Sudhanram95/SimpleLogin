//
//  RegisterPresenter.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import Foundation

class RegisterPresenter: RegisterProtocol {
    
    var registerViewProtocol: RegisterViewProtocol
    let dbConnectivity = DatabaseManager()
    
    
    init(registerViewProtocol: RegisterViewProtocol) {
        self.registerViewProtocol = registerViewProtocol
    }
    
    func onValidateRegistrationForm(email: String, name: String, password: String, confirmPassword: String) -> String  {
        
        var validationResult = ""
        if(email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
            validationResult = "No field must be empty"
        } else if(password != confirmPassword) {
            validationResult = "Password mismatched"
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
    
    func onCreateNewUser(email: String, name: String, password: String) {
        let isUserInserted = dbConnectivity.insertUser(email: email, name: name, password: password)
        registerViewProtocol.onNewuserCreatedResult(isUserCreated: isUserInserted)
    }
}
