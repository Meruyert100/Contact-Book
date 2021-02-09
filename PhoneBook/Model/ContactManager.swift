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
    private (set) var historyUsers: [Contact] = []
    
    init() {
        self.generateUsers()
        self.generateHistoryUsers()
    }
    
    func generateUsers() {
        users.append(Contact(firstName: "Almaz", secondName: "Tastadiyev", phone: "+777 777 777 777", image: UIImage(named: "male.png"), gender: "male"))
    }
    
    func generateHistoryUsers() {
        historyUsers.append(Contact(firstName: "Tom", secondName: "Hanks", phone: "+777 333 222 111", image: UIImage(named: "male.png"), gender: "male"))
    }
    
    func addUser(_ user: Contact){
        users.append(user)
    }
    
    func deleteUser(_ user: Contact){
        guard let index = users.firstIndex(of: user) else { return }
        users.remove(at: index)
    }
    
    func deleteHistoryUser(_ user: Contact){
        guard let index = historyUsers.firstIndex(of: user) else { return }
        historyUsers.remove(at: index)
    }
    
    func editUser(_ user: Contact){
        var currentUsers = users
        guard !currentUsers.isEmpty else { return }
        guard let index = getIndex(of: user, in: users) else { return }
        currentUsers[index] = user
        users = currentUsers
    }
    
    func addHistoryUser(_ user: Contact){
        historyUsers.append(user)
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

