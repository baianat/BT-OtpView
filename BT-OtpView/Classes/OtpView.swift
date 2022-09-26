//
//  OtpView.swift
//  Rigow
//
//  Created by Omar on 3/21/20.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

public protocol OtpViewDelegate {
    /// This delegate method will notify when the user enters 4-digit code
    ///
    /// - Parameters:
    ///   - code: The 4-digit code
    ///   - otpView: The instance of OtpView
    ///
    /// - Returns:
    /// true to dismiss keyboard on last character otherwise false
    func shouldReceive(otpCode code: String, at otpView: OtpView) -> Bool
}

public extension OtpViewDelegate {
    func shouldReceive(otpCode code: String, at otpView: OtpView) -> Bool {
        return false
    }
}

public class OtpView: UIView {

    // MARK: OUTLETS
    @IBOutlet weak var firstField: OtpTextField!
    @IBOutlet weak var secondField: OtpTextField!
    @IBOutlet weak var thirdField: OtpTextField!
    @IBOutlet weak var fourthField: OtpTextField!
    @IBOutlet weak var firstContainer: UIView!
    @IBOutlet weak var secondContainer: UIView!
    @IBOutlet weak var thirdContainer: UIView!
    @IBOutlet weak var fourthContainer: UIView!

    // MARK: Variables
    public var delegate: OtpViewDelegate?
    public var decorator: OtpViewDecorator! {
        didSet {
            stylizeTextFields()
            stylizeTextFieldsContainers()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupViews()

    }

    var view: UIView!

    private func setupViews() {

        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: "OtpView", bundle: Bundle(for: OtpView.self))
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }

        guard let view_ = loadViewFromNib() else { return }
        view = view_
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.removeFromSuperview()
        addSubview(view)
        backgroundColor = .clear
        decorator  = OtpViewDecorator.defaultDecorator
        stylizeTextFieldsContainers()
        stylizeTextFields()
        setupTextFieldsDelegates()

    }

}

// MARK: Styling Functions
extension OtpView {
    fileprivate func stylizeTextFieldsContainers() {
        [firstContainer, secondContainer, thirdContainer, fourthContainer].forEach({
            $0?.setStrokeColor(color: decorator.defaultBorderColor, width: decorator.borderWidth)
            $0?.backgroundColor = decorator.defaultFillColor

            if decorator.isCircle {
                $0?.clipsToBounds = true
                $0?.layer.cornerRadius = ($0?.frame.height ?? 0) / 2
                $0?.layer.masksToBounds = true
            } else {
                $0?.clipsToBounds = true
                $0?.layer.cornerRadius = decorator.cornerRadius
                $0?.layer.masksToBounds = true
            }

        })
    }

    fileprivate func stylizeTextFields() {
        [firstField, secondField, thirdField, fourthField].forEach({
            if decorator.font != nil {
                $0?.font = decorator.font
            }
            if decorator.hideCursor {
                $0?.tintColor = .clear
            }
            if decorator.onlyNumbers {
                $0?.keyboardType = .numberPad
            }
            $0?.isSecureTextEntry =  decorator.isSecuredTextEntry
            $0?.textColor = decorator.textColor
            $0?.placeholder = decorator.placeHolder
        })
    }

    fileprivate func setupTextFieldsDelegates() {
        [firstField, secondField, thirdField, fourthField].forEach({
            $0?.delegate = self
            $0?.backActionDelegate = self
        })
//        firstField.delegate = self
        
        if #available(iOS 12.0, *) {
            firstField.textContentType = .oneTimeCode
        }
        self.firstField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.firstField.becomeFirstResponder()
    }
}

// MARK: TextField Delegate
extension OtpView: UITextFieldDelegate, OtpTextFieldDelegate {

    @objc func textFieldDidChange(_ textField: UITextField) {
        if #available(iOS 12.0, *) {
            
            if textField.textContentType == UITextContentType.oneTimeCode{
                //here split the text to your four text fields
                if let otpCode = textField.text, otpCode.count > 3 {
                    firstField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 0)])
                    secondField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
                    thirdField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
                    fourthField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
                                        
                    if delegate?.shouldReceive(otpCode: verificationCode, at: self) == true || textField.isSecureTextEntry {
                        fourthField.endEditing(true)
                        self.fourthField.resignFirstResponder()
                    }
                }
            }
         }
      }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string.count > 3) {
            firstField.text = String(string[string.index(string.startIndex, offsetBy: 0)])
            secondField.text = String(string[string.index(string.startIndex, offsetBy: 1)])
            thirdField.text = String(string[string.index(string.startIndex, offsetBy: 2)])
            fourthField.text = String(string[string.index(string.startIndex, offsetBy: 3)])
            
            fourthField.becomeFirstResponder()
            
            if delegate?.shouldReceive(otpCode: verificationCode, at: self) == true || textField.isSecureTextEntry {
                fourthField.endEditing(true)
            }
            
            return false
        }
        else if (string.count == 1){
            if textField == firstField {
                secondField?.becomeFirstResponder()
            }
            if textField == secondField {
                thirdField?.becomeFirstResponder()
            }
            if textField == thirdField {
                fourthField?.becomeFirstResponder()
            }
            if textField == fourthField {
                fourthField?.resignFirstResponder()
                textField.text? = string
                
                if delegate?.shouldReceive(otpCode: verificationCode, at: self) == true || textField.isSecureTextEntry {
                    fourthField.endEditing(true)
                    self.fourthField.resignFirstResponder()
                }
                
            }
            textField.text? = string
            return false
        }
        else{
            if textField == firstField {
                firstField?.becomeFirstResponder()
            }
            if textField == secondField {
                firstField?.becomeFirstResponder()
            }
            if textField == thirdField {
                secondField?.becomeFirstResponder()
            }
            if textField == fourthField {
                thirdField?.becomeFirstResponder()
            }
            
            textField.text? = string
            return false
        }
        
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        highlightField(textField: textField)
        return true
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        restoreField(textField: textField)
        return true
    }

    internal func highlightPreviousFiled(currentTextField textField: OtpTextField) {
        textField.text?.removeAll()
        switch textField {
         case self.fourthField:
             self.thirdField.becomeFirstResponder()
         case self.thirdField:
             self.secondField.becomeFirstResponder()
         case self.secondField:
             self.firstField.becomeFirstResponder()
         case self.firstField:
             self.firstField.resignFirstResponder()
             self.firstField.endEditing(true)
         default:
             break
         }
    }

}

// MARK: Highlight Controlling Functions
extension OtpView {
    private func highlightField(textField: UITextField) {
        textField.superview?.setStrokeColor(color: decorator.focusedBorderColor, width: decorator.borderWidth)
        textField.superview?.backgroundColor = decorator.focusedFillColor
    }

    private func restoreField(textField: UITextField) {
        textField.superview?.layer.borderColor = decorator.defaultBorderColor.cgColor
        textField.superview?.backgroundColor = decorator.defaultFillColor
    }
}

// MARK: Exposed Functions
extension OtpView {

    /// This property returns the verification code if its 4 digits, other wise empty string
    public var verificationCode: String {
        get {
            if let a = firstField.text,
                let b = secondField.text,
                let c = thirdField.text,
                let d = fourthField.text {
                return a + b + c + d
            }
            return ""
        }
    }

    /// This method clears all EditTexts
    func clearOtpView() {
        [fourthField, thirdField, secondField, firstField].forEach({
            $0?.text = ""
            $0?.resignFirstResponder()
        })

        firstField.becomeFirstResponder()
    }
}
