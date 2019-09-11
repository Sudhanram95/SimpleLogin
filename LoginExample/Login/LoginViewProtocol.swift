//
//  LoginViewProtocol.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import Foundation

protocol LoginViewProtocol {
    
    func onUserCheckAvailabilityResult(isAvailable: Bool) -> ()
}
