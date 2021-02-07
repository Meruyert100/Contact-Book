//
//  ImageViewExtension.swift
//  PhoneBook
//
//  Created by Meruyert Tastandiyeva on 2/7/21.
//

import UIKit

extension UIImageView {

    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }

}
