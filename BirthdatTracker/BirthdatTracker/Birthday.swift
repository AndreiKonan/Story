//
//  Birthday.swift
//  BirthdatTracker
//
//  Created by Admin on 16.02.23.
//

import Foundation
class Birthday{
    let firstName: String
    let lastName: String
    let birthdate: Date
    init(firstName: String, lastName: String, birthdate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
    }
}
