//
//  ContactManager.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import Foundation
import UIKit

final class ContactManager {
    static let instance = ContactManager()
    
    private (set) var users: [Contact] = []
    init() {
        self.generateUsers()
    }
    
    func generateUsers() {
        users.append(Contact(firstName: "Mer", secondName: "Tass", phone: "+777 777 777 777", image: UIImage(named: "female.png"), gender: "female"))
    }
    
    func addUser(_ user: Contact){
        users.append(user)
    }
    
    func deleteUser(_ user: Contact){
        guard let index = users.firstIndex(of: user) else { return }
        users.remove(at: index)
    }
    
    func editUser(_ user: Contact){
        var currentUsers = users
        guard !currentUsers.isEmpty else { return }
        guard let index = getIndex(of: user, in: users) else { return }
        currentUsers[index] = user
        users = currentUsers
    }
    
    private func getIndex(of user: Contact, in usersArray: [Contact]) -> Int? {
        var indexOfUser: Int?
        for (index, item) in usersArray.enumerated() {
            if item.id == user.id {
                indexOfUser = index
                break
            }
        }
        return indexOfUser
    }
    
}

