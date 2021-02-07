//
//  AddContactViewController.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

class AddContactViewController: UIViewController,  UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    var user: Contact? = Contact(firstName: "", secondName: "", phone: "", gender: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        lastnameTextField.delegate = self
        numberTextField.delegate = self
    }
    
    @IBAction func contactSaved(_ sender: Any) {
        let newFirstName = nameTextField.text ?? ""
        guard !newFirstName.isEmpty else { return }
        user?.firstName = newFirstName
        let newSecondName = lastnameTextField.text ?? ""
        guard !newSecondName.isEmpty else { return }
        user?.secondName = newSecondName
        let newPhone = numberTextField.text ?? ""
        guard !newPhone.isEmpty else { return }
        user!.phone = newPhone
        
        ContactManager.instance.addUser(user!)
        NotificationCenter.default.post(name: .UserEdited, object: nil)
        navigationController?.popViewController(animated: true)
    }
    
}
