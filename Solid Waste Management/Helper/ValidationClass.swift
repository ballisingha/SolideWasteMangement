
//  ValidationClass.swift


import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}

class ValidationClass: NSObject {

    func validateUrl (_ stringURL : NSString) -> Bool {
        let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        //  let urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        return predicate.evaluate(with: stringURL)
    }

    func validate(password: String) -> Bool  {
        let regularExpression = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{7,}"
        //let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        //let regularExpression = "^(?=.*[0-9])(?=.[a-z])(?=.[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,20}$"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        print(passwordValidation.evaluate(with: password))
        return passwordValidation.evaluate(with: password)
    }

    func isBlank (_ textfield:UITextField) -> Bool {
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }

    func isBlankString (_ thetext:String) -> Bool {
        let trimmedString = thetext.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }

    func isTextViewBlank(_ textview:UITextView) -> Bool {
        if textview.text.isEmpty || textview.text == "Growth Description" || textview.text == "Brief about the tree*" {
            return true
        }
        return false
    }

    func isImageViewBlank(_ imageView:UIImageView)-> Bool{
        if imageView.image == UIImage(named: "camera") ||  imageView.image == UIImage(named: "white-logo") || imageView.image == nil {
            return true
        }
        return false
    }

    func isValidEmail(_ EmailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = EmailStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }

    func isValidPhoneNumber(_ PhoneStr:String) -> Bool {
        let phoneRegEx = "[0-9]{10}"
        let range = PhoneStr.range(of: phoneRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return !result
    }

    func isValidPWD(_ PwdStr:String) -> Bool {
        let PwdRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let range = PwdStr.range(of: PwdRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }

    
//    func ValidateSignUp(_ loginVCValidateObj:SignUpVC) -> Bool {
//        if isBlank(loginVCValidateObj.txtUserName)   //|| isValidEmail(loginVCValidateObj.txtEmailID.text!)
//        {
//            loginVCValidateObj.view.makeToast(message: "Please enter your User Name.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        } else if isBlank(loginVCValidateObj.txtStatus) {
//            loginVCValidateObj.view.makeToast(message: "Please enter your Status.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        }  else if isValidEmail(loginVCValidateObj.txtEmail.text!) {
//            loginVCValidateObj.view.makeToast(message: "Please enter a valid Email")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        }   else if isBlank(loginVCValidateObj.txtPassword) {
//            loginVCValidateObj.view.makeToast(message: "Please enter your Password.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        }   else if (loginVCValidateObj.txtPassword.text!) != (loginVCValidateObj.txtConfirmPassword.text!) {
//            loginVCValidateObj.view.makeToast(message: "Password does not match")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        } else {
//            return true
//        }
//    }
//
//    func ValidateLogin(_ loginVCValidateObj:LoginVC) -> Bool {
//        if isBlank(loginVCValidateObj.txtEmailId) || isValidEmail(loginVCValidateObj.txtEmailId.text!)
//        {
//            loginVCValidateObj.view.makeToast(message: "Please enter Email ID.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        } else if isBlank(loginVCValidateObj.txtPassword) {
//            loginVCValidateObj.view.makeToast(message: "Please enter your Password.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        } else {
//            return true
//        }
//    }
//
//    func ForgotPassword(_ obj:ForgotPasswordVC) -> Bool {
//        if isBlank(obj.txtEmail) || isValidEmail(obj.txtEmail.text!)
//        {
//            obj.view.makeToast(message: "Please enter Email ID.")
//            obj.view.endEditing(true)
//            return false
//        } else {
//            return true
//       }
//    }
//
//
//        func ResetPassword(_ obj: ResetPasswordVC) -> Bool {
//           obj.view.endEditing(true)
//           if isBlank(obj.txtPassword) {
//                obj.view.makeToast(message: "Please enter Password.")
//                return false
//            } else if obj.txtPassword.text!.count < 8 {
//                obj.view.makeToast(message: "Password should be at least 8 characters long.")
//                return false
//            } else if isBlank(obj.txtConfirmPassword) {
//                obj.view.makeToast(message: "Please enter Confirm Password.")
//                return false
//            } else if obj.txtConfirmPassword.text! != obj.txtPassword.text! {
//                obj.view.makeToast(message: "Confirm Password should be same as Password.")
//                return false
//            } else {
//                return true
//            }
//        }
//
//
//    func regsitarionForm(_ obj: SignUpVC) -> Bool {
//        obj.view.endEditing(true)
//        if isBlank(obj.txtUserName) {
//            obj.view.makeToast(message: "Please enter User Name.")
//            return false
//        } else if isBlank(obj.txtStatus) {
//            obj.view.makeToast(message: "Please select Status.")
//            return false
//        }  else  if isBlank(obj.txtEmailID) // || isValidEmail(obj.txtEmail.text!)
//        {
//            obj.view.makeToast(message: "Please enter Email ID.")
//            return false
//        } else if isBlank(obj.txtPassword) {
//            obj.view.makeToast(message: "Please enter Password.")
//            return false
//        } else if obj.txtPassword.text!.count < 8 {
//          obj.view.makeToast(message: "Password should be at least 8 characters long.")
//            return false
//
//        }
////            else if  isBlank(obj.txtPassword) || isValidPWD(obj.txtPassword.text!) {
////            obj.view.makeToast(message: "The password must have minimum 8 characters, contain Uppercase letters(A-Z), Lowercase letters(a-z), Number(0-9) and special character like(@,$,&).")
////            return false
////        }
//        else {
//            return true
//        }
//    }
//
   


//extension String {
//    var isPhoneNumber: Bool {
//        do {
//            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
//            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
//            if let res = matches.first {
//                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && self.count == 10
//            } else {
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
}

