//
//  Notification.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import Foundation

extension Notification.Name {
    static let UserDeleted = Notification.Name("UserDeleted")
    static let UserEdited = Notification.Name("UserEdited")
    static let HistoryUserEdited = Notification.Name("UserAddedToHistory")
}
