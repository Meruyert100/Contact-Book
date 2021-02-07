//
//  ContactDetailsViewController.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

class ContactDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    var user: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImageView.image = user?.image
        nameTextField.text = user?.firstName
        lastnameTextField.text = user?.secondName
        numberTextField.text = user?.phone
        
        nameTextField.delegate = self
        lastnameTextField.delegate = self
        numberTextField.delegate = self
        
    }
    
    @IBAction func contactSaved(_ sender: Any) {
        guard var editedUser = user else { return }

        let newFirstName = nameTextField.text ?? ""
        guard !newFirstName.isEmpty else { return }
        editedUser.firstName = newFirstName
        let newSecondName = lastnameTextField.text ?? ""
        guard !newSecondName.isEmpty else { return }
        editedUser.secondName = newSecondName
        let newPhone = numberTextField.text ?? ""
        guard !newPhone.isEmpty else { return }
        editedUser.phone = newPhone
        
        ContactManager.instance.editUser(editedUser)
        NotificationCenter.default.post(name: .UserEdited, object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactDeleted(_ sender: Any) {
        guard let user = user else { return }
        ContactManager.instance.deleteUser(user)
        NotificationCenter.default.post(name : .UserDeleted, object: nil)
        navigationController?.popViewController(animated: true)
    }

}
