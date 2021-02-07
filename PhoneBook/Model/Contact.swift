//
//  Contact.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

struct Contact {
    private static var objectCounter = 0
    let id: Int
    var firstName: String
    var secondName: String
    var phone: String
    var image: UIImage?
    var gender: String
    
    init(firstName: String, secondName: String, phone: String, image: UIImage? = nil, gender: String) {
        Contact.objectCounter += 1
        self.id = Contact.objectCounter
        self.firstName = firstName
        self.secondName = secondName
        self.phone = phone
        self.image = image
        self.gender = gender
    }
}

extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.phone == rhs.phone
    }
}
