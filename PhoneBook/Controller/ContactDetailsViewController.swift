//
//  ContactDetailsViewController.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

protocol DeleteUserProtocol {
    func deleteUser(_ i: Int)
}

class ContactDetailsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: DeleteUserProtocol?

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    var user: Contact?
    var gender: String?
    var index: Int?
    
    var pickerData = ["Male","Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImageView.image = user?.image
        nameTextField.text = user?.firstName
        lastnameTextField.text = user?.secondName
        numberTextField.text = user?.phone
        
        nameTextField.delegate = self
        lastnameTextField.delegate = self
        numberTextField.delegate = self
        genderPickerView.delegate = self
        
        if user?.gender == "male" {
            genderPickerView.selectRow(0, inComponent: 0, animated: false)
        } else {
            genderPickerView.selectRow(1, inComponent: 0, animated: false)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? MakeCallViewController else { return }
        let callUser = user
        destVC.user = callUser
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
        let newGender = gender ?? user?.gender
        guard !newGender!.isEmpty else { return }
        editedUser.gender = newGender!
        
        if editedUser.gender == "Male" || editedUser.gender == "male"  {
            editedUser.image = UIImage(named: "male.png")
        } else {
            editedUser.image = UIImage(named: "female.png")
        }
        
        ContactManager.instance.editUser(editedUser)
        NotificationCenter.default.post(name: .UserEdited, object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactDeleted(_ sender: Any) {
//        guard let user = user else { return }
//        ContactManager.instance.deleteUser(user)
//        NotificationCenter.default.post(name : .UserDeleted, object: nil)
//        navigationController?.popViewController(animated: true)
        delegate?.deleteUser(index!)
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
