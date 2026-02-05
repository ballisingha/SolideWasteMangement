//
//  OTPVerificationVC.swift
//  Solid Waste Management
//
//  Created by Guriqbal Singh Amroke on 08.01.26.
//

import UIKit

class OTPVerificationVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var otpFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupOTPFields()
    }
    
    
    @IBAction func signInPressed(_ sender: Any) {
        let otpCode = otpFields.map { $0.text ?? "" }.joined()
        print("Entered OTP Code: \(otpCode)")
    }
    
    private func setupOTPFields() {
        otpFields.sort { $0.tag < $1.tag }
        
        for field in otpFields {
            field.delegate = self
            field.keyboardType = .numberPad
            field.textAlignment = .center
            field.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            field.layer.borderWidth = 8
            field.layer.borderWidth = 1
            field.layer.borderColor = UIColor.BorderColor.cgColor
        }
    }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else { return false }
            let newText = (text as NSString).replacingCharacters(in: range, with: string)
        
            if newText.count == 1 {
                textField.text = newText
                if textField.tag < otpFields.count - 1 {
                    otpFields[textField.tag + 1].becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
                return false
            } else if newText.isEmpty {
                if textField.tag > 0 {
                    otpFields[textField.tag - 1].becomeFirstResponder()
                }
                textField.text = ""
                return false
            }
            return false
            }
        
    }

