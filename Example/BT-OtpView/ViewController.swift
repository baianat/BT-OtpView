//
//  ViewController.swift
//  BT-OtpView
//
//  Created by O-labib on 09/17/2020.
//  Copyright (c) 2020 O-labib. All rights reserved.
//

import UIKit
import BT_OtpView
class ViewController: UIViewController {
    
    @IBOutlet weak var otpView: OtpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpView.decorator = OtpViewDecorator(defaultBorderColor: .magenta,focusedBorderColor: .blue,textColor: .black)
        otpView.delegate = self
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

extension ViewController : OtpViewDelegate {
    
    func shouldReceive(otpCode code: String, at otpView: OtpView) -> Bool {
        print(code)
        return true
    }
    
    
}
