//
//  Constants.swift
//
//

import Foundation
import UIKit

//struct K {
    //static let appName = "Mazall"
    
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

    struct NetworkConstants {
        static let localServer = "http://18.216.142.130:90/api/" // local server
     //   static let devServer = "https://dev.mazall.com/v1/api/" // dev server
        static let baseURLPath = localServer
//
//
//        static let imageUrl = "http://18.233.233.181:3000/"
//                static let imageUrl = "https://dev.mazall.com/v1/"
       // static let imageUrl = "https://mazallweb.s3.amazonaws.com/"
        
    }
    struct WebService {
        static let Login = NetworkConstants.baseURLPath + "login/"
        static let SignUp = NetworkConstants.baseURLPath + "register/"
        static let UpdatePassword = NetworkConstants.baseURLPath + "update_password/?token=" 
        static let ForgotPassword = NetworkConstants.baseURLPath + "forgot_password/"
        static let ResetPassword = NetworkConstants.baseURLPath + "resetPassword"
        static let GetProfile = NetworkConstants.baseURLPath + "view_profile_detail/"
        static let GetAllUser = NetworkConstants.baseURLPath + "list_all_user/"
        static let updateProfile = NetworkConstants.baseURLPath + "edit_profile_detail/"
        static let addPost = NetworkConstants.baseURLPath + "add_post/"
        static let editPost = NetworkConstants.baseURLPath + "edit_post/"
        static let getAllUserPost = NetworkConstants.baseURLPath + "view_all_user_post/"

        
        //static let getProfile = NetworkConstants.baseURLPath + "getProfile"
        static let verifyEmailCode = NetworkConstants.baseURLPath + "verifyEmailCode"
        static let resendEmailOtpCode = NetworkConstants.baseURLPath + "resendEmailOtpCode"
        static let acceptGroupRequest = NetworkConstants.baseURLPath + "acceptGroupRequest"
        static let createProduct = NetworkConstants.baseURLPath + "createProduct"
        static let getAllProducts = NetworkConstants.baseURLPath + "getAllProducts"
        static let  updateProduct = NetworkConstants.baseURLPath + "updateProduct"
         
       
    }
    
    struct UserDefaultKeys {
        static let LoginData = "LoginData"
        
    }
    




