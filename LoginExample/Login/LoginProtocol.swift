//
//  LoginProtocol.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import Foundation

protocol LoginProtocol {
    func onValidateLogin(email: String, password: String) -> String
    func checkUserAvailability(email: String, password: String) -> () 
}
