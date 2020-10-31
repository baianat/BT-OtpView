//
//  Decorator.swift
//  OTP
//
//  Created by Omar on 8/9/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import Foundation
import UIKit

public struct OtpViewDecorator {

    var defaultBorderColor: UIColor = .gray
    var focusedBorderColor: UIColor = .black
    var cornerRadius: CGFloat = 16
    var borderWidth: CGFloat = 1
    var defaultFillColor = UIColor.green
    var focusedFillColor = UIColor.orange
    var isCircle = false
    var hideCursor = true
    var isSecuredTextEntry = false
    var onlyNumbers = true
    var placeHolder = ""
    var textColor: UIColor = .black
    var font: UIFont?

    public init(
        defaultBorderColor: UIColor = .gray,
                focusedBorderColor: UIColor = .black,
                cornerRadius: CGFloat = 16,
                borderWidth: CGFloat = 1,
                defaultFillColor: UIColor = .clear,
                focusedFillColor: UIColor = .clear,
                hideCursor: Bool = true,
                isSecuredTextEntry: Bool = false,
//                isCircle: Bool = false,
                onlyNumbers: Bool = true,
                placeHolder: String = "",
                textColor: UIColor = .black,
                font: UIFont? = nil
    ) {
        self.defaultBorderColor = defaultBorderColor
        self.focusedBorderColor = focusedBorderColor
        self.cornerRadius = cornerRadius
        self.defaultFillColor = defaultFillColor
        self.borderWidth = borderWidth
        self.defaultFillColor = defaultFillColor
        self.focusedFillColor = focusedFillColor
        self.hideCursor = hideCursor
        self.isSecuredTextEntry = isSecuredTextEntry
//        self.isCircle = isCircle
        self.placeHolder = placeHolder
        self.textColor = textColor
        self.font = font
        self.onlyNumbers = onlyNumbers
    }

    static var defaultDecorator: OtpViewDecorator {
        get {
            return OtpViewDecorator()
        }
    }

}
