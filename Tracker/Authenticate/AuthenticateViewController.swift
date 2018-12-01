//
//  AuthenticateViewController.swift
//  Tracker
//
//  Created by Victor Grajski on 11/30/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticateViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var faceIDLabel: UILabel!
    
    /// An authentication context stored at class scope so it's available for use during UI updates.
    var context = LAContext()
    
    /// The available states of being logged in or not.
    enum AuthenticationState {
        case loggedin, loggedout
    }
    
    /// The current authentication state.
    var state = AuthenticationState.loggedout {
        
        // Update the UI on a change.
        didSet {
            loginButton.isHighlighted = state == .loggedin  // The button text changes on highlight.
            stateView.backgroundColor = state == .loggedin ? UIColor(red: CGFloat(84/255.0), green: CGFloat(170/255.0), blue: CGFloat(155/255.0), alpha: 1.0) : UIColor(red: CGFloat(250/255.0), green: CGFloat(244/255.0), blue: CGFloat(242/255.0), alpha: 1.0)
            
            // FaceID runs right away on evaluation, so you might want to warn the user.
            //  In this app, show a special Face ID prompt if the user is logged out, but
            //  only if the device supports that kind of authentication.
            if #available(iOS 11.0, *) {
                faceIDLabel.isHidden = (state == .loggedin) || (context.biometryType != .faceID)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    convenience init() {
        self.init(nibName: "AuthenticateViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The biometryType, which affects this app's UI when state changes, is only meaningful
        //  after running canEvaluatePolicy. But make sure not to run this test from inside a
        //  policy evaluation callback (for example, don't put next line in the state's didSet
        //  method, which is triggered as a result of the state change made in the callback),
        //  because that might result in deadlock.
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        
        // Set the initial app state. This impacts the initial state of the UI as well.
        state = .loggedout
    }
    
    /// Logs out or attempts to log in when the user taps the button.
    @IBAction func tapButton(_ sender: UIButton) {
        
        if state == .loggedin {
            
            // Log out immediately.
            state = .loggedout
            
        } else {
            
            // Get a fresh context for each login. If you use the same context on multiple attempts
            //  (by commenting out the next line), then a previously successful authentication
            //  causes the next policy evaluation to succeed without testing biometry again.
            //  That's usually not what you want.
            context = LAContext()
            
            context.localizedCancelTitle = "Enter Username/Password"
            
            // First check if we have the needed hardware support.
            var authError: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
                
                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, evaluateError in
                    
                    if success {
                        
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            self.state = .loggedin
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                    } else {
                        guard let error = evaluateError else {
                            return
                        }

                        print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    }
                }
            } else {
                guard let error = authError else {
                    return
                }
                //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
                print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
            }
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
}
