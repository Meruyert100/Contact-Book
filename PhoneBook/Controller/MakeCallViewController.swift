//
//  MakeCallViewController.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

class MakeCallViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var user: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = user?.firstName
        userImageView.image = user?.image
        
    }
    
    @IBAction func callEnded(_ sender: Any) {
        self.dismiss(animated: true, completion: .none)
        ContactManager.instance.addHistoryUser(user!)
        NotificationCenter.default.post(name: .HistoryUserEdited, object: nil)
    }

}
