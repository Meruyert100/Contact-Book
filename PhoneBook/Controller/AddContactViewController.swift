//
//  AddContactViewController.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

class AddContactViewController: UIViewController,  UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    var user: Contact? = Contact(firstName: "", secondName: "", phone: "", gender: "")
    var gender: String?
    
    var pickerData = ["Male","Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        lastnameTextField.delegate = self
        numberTextField.delegate = self
        genderPickerView.delegate = self
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
        user?.phone = newPhone
        let newGender = gender ?? "Male"
        guard !newGender.isEmpty else { return }
        user?.gender = newGender
        
        if user?.gender == "Male" {
            user?.image = UIImage(named: "male.png")
        } else {
            user?.image = UIImage(named: "female.png")
        }
        
        ContactManager.instance.addUser(user!)
        NotificationCenter.default.post(name: .UserEdited, object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = pickerData[row]
    }
    
}
