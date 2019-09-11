//
//  RegisterProtocol.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import Foundation

protocol RegisterProtocol {
    func onValidateRegistrationForm(email: String, name: String, password: String, confirmPassword: String) -> String 
    func onCreateNewUser(email: String, name: String, password: String) -> () 
}
