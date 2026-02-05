//
//  Config.swift
//  AberDriver
//
//  Created by gipl on 05/02/20.
//  Copyright © 2020 gipl. All rights reserved.
//


import Foundation
import UIKit

class Config: NSObject, UIAlertViewDelegate {
    
    static let shared = Config()
    static let appmode : APPMODE = .demo //set Api envirment
// sid   static var isLogin: Bool {
//        return Config.UDValue(.login) == "yes"
//    }
    
    let AppAlertTitle = "KIT"
    let AppUserDefaults = UserDefaults.standard
    
    let dateFormat = "dd/MM/yyyy"//"yyyy-MM-dd"
    let ISODateFormat = "dd/mm/yyyy'T'HH:mm:ss.SSSZ"//"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let dateTimeFormat = "dd/MM/yyyy hh:mm a"
    let timeFormat = "hh:mm a"
    
    let currency = "₹ "
    
    let debug_mode = 1
    let googleApiKey =  "AIzaSyCY8sRFt9jkw5DHoTAEO4jwa_oMFE6c37k"//"AIzaSyCGyWv_d65W9Ft6N13eYou9j-n8wHmdjEM"
    let googleDirectionKey = "AIzaSyCY8sRFt9jkw5DHoTAEO4jwa_oMFE6c37k"//"AIzaSyCGyWv_d65W9Ft6N13eYou9j-n8wHmdjEM"
    
    
    //print function based on debug mode
    func printData(_ dataValue : Any ){
        if debug_mode == 1 {
            print(dataValue)
        }
    }
    
    
    var calendar: Calendar {
        let calendar = Calendar.current
        return calendar
    }
    
    var API_URL: String {
        switch Config.appmode {
        case .dev :
            return "http://wheelr.dev2.gipl.inet:21032/api/front_bases_api_response"
        case .demo :
            return "http://wheelrmobileapi.stage2.demo321.com/api/front_bases_api_response"
           // return "http://wheelr.stage2.demo321.com/api/front_bases_api_response"
        case .live :
            return ""
        default:
            return ""
        }
    }
    
    var AUTH_KEY: String {
        switch Config.appmode {
        case .dev :
            return ""
        case .demo :
            return ""
        case .live :
            return ""
        default:
            return ""
        }
    }
    
    
    enum UDKeys: String {
        case rememberMe
        case loginusername
        case loginpassword
        case id
        case user_id
        case login
        case isLogin
        case deviceToken
        case first_name
        case last_name
        case email
        case rating
        case mobile_number
        case phone_number
        case gender
        case date_of_birth
        case slug
        case full_name
        case image_path
        case _id
        case area_id
        case area_name_en
        case area_name_ar
        case currentLat
        case currentLong
        case currentAddress
        case locAddressDestination
        case locLatitudeDestination
        case locLongitudeDestination
        case locAddressSource
        case locLatitudeSource
        case locLongitudeSource
        case profile_image
        case amount
        case user_image_path
        case is_email_verified
        case cash
        case rideId
        case referral_code
        case pnOTP
       // case driver_slug
        
        case showViewOnHome
        case is_have_current_booking
        
       // case imageUrl
        
    }
    
    enum APPMODE {
        case dev
        case testing
        case demo
        case live
    }
  
    enum Poppins: String {
        case regular    = "Poppins-Regular"
    //    case semibold   = "OpenSans-Semibold"
    //    case bold       = "OpenSans-Bold"
    }
    
    func AppFont(_ fontSize:CGFloat,fontType: Poppins) -> UIFont {
        var fontName : String!
        
        switch fontType {
       
        case .regular:
            fontName = Poppins.regular.rawValue
            break
    //    case .semibold:
    //        fontName = OpenSansCode.semibold.rawValue
    //        break
    //    case .bold:
    //        fontName = OpenSansCode.bold.rawValue
    //        break
      
        }
        return UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    
//    func AppFont(_ fontSize:CGFloat,fontType:OpenSansCode) -> UIFont {
//        var fontName : String!
//
//        switch fontType {
//
//        case .regular:
//            fontName = OpenSansCode.regular.rawValue
//            break
//        case .semibold:
//            fontName = OpenSansCode.semibold.rawValue
//            break
//        case .bold:
//            fontName = OpenSansCode.bold.rawValue
//            break
//
//        }
//        return UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
//    }
    
    //MARK: - This function is used to save value in userdefault
    static func UDSave(_ value: Any?,forKey: UDKeys) {
        let userDefaults = UserDefaults.standard
        guard let value = value else { return }
        userDefaults.setValue(value, forKey: forKey.rawValue)
        userDefaults.synchronize()
    }
    
//sid    //MARK: - This function is used to get saved value from userdefault
//    static  func UDValue(_ forKey: UDKeys) -> String {
//        let value = DataManager.getVal(Config.shared.AppUserDefaults.value(forKey: forKey.rawValue))
//        return value
//    }
    
//    //MARK: - This function is used to get saved bool value from userdefault
//        static  func UDBoolValue(_ forKey: UDKeys) -> Bool {
//            let value 
//            return value
//        }
    
    //MARK: - This function is used to show info in alert
    func showInfo(_ viewController: UIViewController,message: String, Title: String = Config.shared.AppAlertTitle) {
        let alertController = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - This function is used to show alert when error occur in app
    func showError(_ viewController: UIViewController,message: String) {
        let alertController = UIAlertController(title: self.AppAlertTitle, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - This function is used to show alert with OK and CANCEL button
    func customInfoBtnAction(_ viewController: UIViewController,message: String, title: String = Config.shared.AppAlertTitle,completion:@escaping (_ result:Bool) -> Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completion(true)
        }))
    }
    
    //MARK: - This function is used to show alert for ask permission
    func AskConfirmation (_ viewController: UIViewController, title: String = Config.shared.AppAlertTitle, message:String, okAction: String = "Ok", cancelAction: String = "Cancel", completion:@escaping (_ result:Bool) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: { action in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: cancelAction, style: .default, handler: { action in
        }))
    }
    
    
//    func UDClear() {
//        let deviceToken = Config.UDValue(.deviceToken)
//        let loginusername = Config.UDValue(.loginusername)
//        let loginpassword = Config.UDValue(.loginpassword)
//        let rememberMe = Config.UDValue(.rememberMe)
//
//
//        let defaults =  UserDefaults.standard
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            if !(key != UDKeys.deviceToken.rawValue) {
//                defaults.removeObject(forKey: key)
//            }
//        }
//
//        Config.UDSave("", forKey: .user_id)
//        Config.UDSave("", forKey: .slug)
//        Config.UDSave("", forKey: .full_name)
//        Config.UDSave("", forKey: .first_name)
//        Config.UDSave("", forKey: .last_name)
//        Config.UDSave("", forKey: .image_path)
//        Config.UDSave("", forKey: .profile_image)
//        Config.UDSave("", forKey: .rating)
//        Config.UDSave("", forKey: .amount)
//
//        Config.UDSave(deviceToken, forKey: .deviceToken)
//        Config.UDSave(loginpassword, forKey: .loginpassword)
//        Config.UDSave(loginusername, forKey: .loginusername)
//        Config.UDSave(rememberMe, forKey: .rememberMe)
//        defaults.synchronize()
//    }
//sid
    
//    func resizeImage(_ image:UIImage) -> UIImage {
//        
//        let actualHeight = Int(image.size.height);
//        let actualWidth = Int(image.size.width);
//        let compressionQuality:CGFloat = 0.3
//        let newsizeWidth = CGFloat( actualWidth ) * CGFloat(compressionQuality)
//        let newsizeHeight = CGFloat( actualHeight ) * CGFloat(compressionQuality)
//        let newSize = CGSize(width: newsizeWidth , height: newsizeHeight);
//        // Scale the original image to match the new size.
//        UIGraphicsBeginImageContext(newSize);
//        image.draw(in: CGRect(x: 0, y: 0 , width: newSize.width , height: newSize.height))
//        let compressedImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        return compressedImage!.resizedTo2MB()!
//    }
    
}

