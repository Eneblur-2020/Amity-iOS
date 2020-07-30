//
//  constants.swift
//  Amity
//
//  Created by Vinayak Tudayekar on 02/07/20.
//  Copyright © 2020 Eneblur Consulting. All rights reserved.
//

import Foundation
import UIKit

let POLICY_URL = "qa.backend.afawebapp.zotalabs.com"
let BASE_URL = "https://qa.backend.afawebapp.zotalabs.com/"

//SIGNUP LOGIn API

let SIGNUP_BY_EMAIL_API = "\(BASE_URL)authentication/signUpByEmail"

let SIGNUP_MOBILE_API = "\(BASE_URL)authentication/mobile"

// SIGN IN

let LOGIN_EMAIL_API = "\(BASE_URL)authentication/login"

let LOGIN_MOBILE_API = "\(BASE_URL)authentication/mobile"

//LOGOUT
let LOGOUT_API = "\(BASE_URL)authentication/logout"

// AUTHENTICATION
let USER_API = "\(BASE_URL)authentication/user"

//OTP VERIFICATION
let VERIFY_MOBILE_OTP = "\(BASE_URL)authentication/verifyMobileOTP"

//FORGOT/RESET PASSWORD
let FORGOT_PASSWORD_RECOVER_API = "\(BASE_URL)authentication/recover"

let VALIDATION_TOKEN_API = "\(BASE_URL)authentication/validateToken/"

let RESET_PASSWORD_API = "\(BASE_URL)authentication/resetPassword/"

//WEBINAR API
let WEBINAR_API = "\(BASE_URL)webinar"

let WEBINAR_UPCOMING_API = "\(BASE_URL)webinar?type=upcoming"
//ALL EVENTS

let EVENT_API = "\(BASE_URL)event"

//GALLERY API

let GALLERY_API = "\(BASE_URL)gallery"

//STUDENT

let DOCUMENTS_API = "\(BASE_URL)student/documents"

//PROFILE API

let PROFILE_SUMMARY_API = "\(BASE_URL)profile/summary"

let EXPERIENCE_API = "\(BASE_URL)profile/experience"

let UPDATE_EXPERIENCE_API = "\(BASE_URL)profile/experience/"

let UPDATE_NAME_API = "\(BASE_URL)profile/updateName"

let UPDATE_EMAIL_API = "\(BASE_URL)profile/updateEmail"

let UPDATE_MOBILE_API = "\(BASE_URL)profile/updateContactNumber"

let SUMMARY_API = "\(BASE_URL)profile/summary"

let EDUCATION_API = "\(BASE_URL)profile/education"

let UPDATE_EDUCATION_API = "\(BASE_URL)profile/education/"

let RESUME_UPLOAD_API = "\(BASE_URL)profile/resume"

let DELETE_EXPERIENCE_API = "\(BASE_URL)profile/experience/"

let DELETE_EDUCATION_API = "\(BASE_URL)profile/education/"

let GET_COURSES_API = "\(BASE_URL)course"
//courseCategory
let GET_COURSECATEGORY_API = "\(BASE_URL)courseCategory"

let SUBMIT_STUDENTAPPLICATION_API = "\(BASE_URL)course/student/register"
//
let GET_STUDENTWALLET_API = "\(BASE_URL)student/documents"

///documentIssuance/documentURL
let GET_DOCUMENTS_URL_API = "\(BASE_URL)documentIssuance/documentURL"
///
///ALERT MESSAGES
var NO_INTERNET = "No Internet Connection"
let REQUEST_TIME_OUT = "Request could not be completed. Please try again."
let ACCOUNT_CREATED = "Account has been successfully created and verified. Please log in to continue."
let INCORRECT_OTP = "Please enter a valid verification code."
let RESEND_OTP = "New verification code has been successfully sent to the registered email address."
let SECONDARY_FONT = UIFont(name: "Roboto", size: 15.0)

// SEGUE BOOL
 var isFromOTPSegue = 0

//ARRAY DECLARATION
var webinorArray = [Webinor]()
var upComingWebinorArray = [Webinor]()
var eventArray = [Event]()
var galleryArray = [Gallery]()
var imageArray = [Gallery]()
var uniqueimageArray = [Gallery]()
var videoArray = [Gallery]()


enum Storyboard: String {
    case Main
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

//KEY VALUE
let WEBINAR = "WEBINAR"
let EVENT = "EVENT"
 

//Login check
struct LoginDetails {
    static let isLogin = "LoggedIn"
}
