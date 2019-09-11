//
//  DatabaseManager.swift
//  LoginExample
//
//  Created by Sudhan Ram on 11/09/19.
//  Copyright © 2019 Sudhan Ram. All rights reserved.
//

import Foundation
import SQLite

class DatabaseManager {
    
    var database: Connection!
    
    let usersTable = Table("users")
    let email = Expression<String>("email")
    let userName = Expression<String>("name")
    let password = Expression<String>("password")
    
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            
            database = try Connection(fileUrl.path)
        } catch {
            print("Init::::::::\(error)")
        }
    }
    
    func createUserTable()  {
        let createTable = self.usersTable.create { (table) in
            table.column(email, primaryKey: true)
            table.column(userName)
            table.column(password)
        }
        
        do {
            try self.database.run(createTable)
            print("User table created")
        } catch {
            print("Create table::::\(error)")
        }
    }
    
    func insertUser(email: String, name: String, password: String) -> Bool  {
        let insertUser = self.usersTable.insert(self.email <- email, self.userName <- name, self.password <- password)
        
        do {
            try self.database.run(insertUser)
            print("User inserted successfully")
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    func isUserAvailable(email: String, password: String) -> Bool {
        do {
            let users = try self.database.prepare(self.usersTable)
            
            let currentUser = users.filter { (user) -> Bool in
                user[self.email] == email &&
                user[self.password] == password
            }
            
            return currentUser.count == 1
            
        } catch {
            print(error)
        }
        return false
    }
}
