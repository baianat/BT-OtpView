//
//  OtpTextField.swift
//  Rigow
//
//  Created by Omar on 8/8/20.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

protocol OtpTextFieldDelegate {
    func highlightPreviousFiled(currentTextField textField: OtpTextField)
}

internal class OtpTextField: UITextField {

    var backActionDelegate: OtpTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        backActionDelegate?.highlightPreviousFiled(currentTextField: self)
    }

}

extension UIView {
    func setStrokeColor(color: UIColor?, width: CGFloat) {
        self.clipsToBounds = true
        self.layer.borderColor = color?.cgColor
        self.layer.borderWidth = width
        self.layer.masksToBounds = true
    }
}
