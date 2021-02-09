//
//  HistoryViewController.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/9/21.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var historyContacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        setupHistoryContacts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(historyUserAdded), name: .HistoryUserEdited , object: nil)
    }
    
    private func setupHistoryContacts() {
        historyContacts = ContactManager.instance.historyUsers
        if historyContacts.isEmpty {
            navigationItem.title = "No History yet"
        } else {
            navigationItem.title = "History"
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyContacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyContactCell") as? HistoryContactTableViewCell else {
            fatalError("Error")
        }
        let user = historyContacts[indexPath.row]
        cell.textLabel?.text = user.firstName + " " + user.secondName
        cell.detailTextLabel?.text = "Call was today"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                
                 let historyContact = self.historyContacts[indexPath.row]
                 
                 ContactManager.instance.deleteHistoryUser(historyContact)

                self.setupHistoryContacts()
            }

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
    @objc private func historyUserAdded() {
        setupHistoryContacts()
    }
}


