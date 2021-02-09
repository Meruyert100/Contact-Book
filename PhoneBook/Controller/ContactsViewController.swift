//
//  ViewController.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupContacts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDeleted), name: .UserDeleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userEdited), name: .UserEdited, object: nil)
    }
    
    private func setupContacts() {
        contacts = ContactManager.instance.users
        if contacts.isEmpty {
            navigationItem.title = "No Contacts yet"
        } else {
            navigationItem.title = "Contacts"
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? ContactDetailsViewController else { return }
        guard let cell = sender as? ContactTableViewCell,
            let indexPath = tableView.indexPath(for: cell) else { return }
        let user = contacts[indexPath.row]
        destVC.user = user
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactTableViewCell") as? ContactTableViewCell else {
            fatalError("Error")
        }
        let user = contacts[indexPath.row]
        let userAvatar = user.image ?? UIImage(systemName: "person")
        let userPhone = user.phone
        cell.update(name: user.firstName + " " + user.secondName, number: userPhone, image: userAvatar!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                
                 let contact = self.contacts[indexPath.row]
                 
                 ContactManager.instance.deleteUser(contact)

                self.setupContacts()
            }

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    

}


extension ContactsViewController {
    @objc private func userDeleted() {
        setupContacts()
    }
    @objc private func userEdited() {
        setupContacts()
    }
}
