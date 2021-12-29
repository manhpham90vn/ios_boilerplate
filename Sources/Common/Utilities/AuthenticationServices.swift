//
//  AuthenticationServices.swift
//  VIPER
//
//  Created by Manh Pham on 3/2/21.
//

import Foundation
import SafariServices
import AuthenticationServices

enum SafariExtensionFactory {
    
    static func provideAuthenticationService() -> AuthenticationServices {
        var authentication: AuthenticationServices!
        if #available(iOS 12.0, *) {
            authentication = ASWebAuthenticationWrapper()
        } else {
            authentication = SFWebAuthenticationWrapper()
        }
        return authentication
    }
}

protocol AuthenticationServices {
    
    var safariSession: Any? { get }
    var userCancelError: NSError! { get }
    
    func initiateSession(url: URL, callBackURL: String, completionHandler:@escaping ((URL?, Error?) -> Void))
    func startSession()
    func cancelSession()
}

final class SFWebAuthenticationWrapper: NSObject, AuthenticationServices {
    var safariSession: Any?
    var userCancelError: NSError!
    
    func initiateSession(url: URL, callBackURL: String, completionHandler: @escaping ((URL?, Error?) -> Void)) {
        self.userCancelError = NSError(domain: "com.apple.SafariServices.Authentication", code: 1, userInfo: nil)
        self.safariSession = ASWebAuthenticationSession(url: url, callbackURLScheme: callBackURL, completionHandler: completionHandler)
    }
    
    func startSession() {
        (self.safariSession as! ASWebAuthenticationSession).start()
    }
    
    func cancelSession() {
        (self.safariSession as! ASWebAuthenticationSession).cancel()
    }
    
}

@available(iOS 12.0, *)
final class ASWebAuthenticationWrapper: NSObject, AuthenticationServices, ASWebAuthenticationPresentationContextProviding {
    
    var safariSession: Any?
    var userCancelError: NSError!
    
    func initiateSession(url: URL, callBackURL: String, completionHandler: @escaping ((URL?, Error?) -> Void)) {
        self.userCancelError = NSError(domain: "com.apple.AuthenticationServices.WebAuthenticationSession", code: 1, userInfo: nil)
        self.safariSession = ASWebAuthenticationSession(url: url, callbackURLScheme: callBackURL, completionHandler: completionHandler)
        if #available(iOS 13.0, *) {
            (self.safariSession as! ASWebAuthenticationSession).presentationContextProvider = self
            (self.safariSession as! ASWebAuthenticationSession).prefersEphemeralWebBrowserSession = true
        }
    }
    
    func startSession() {
        (self.safariSession as! ASWebAuthenticationSession).start()
    }
    
    func cancelSession() {
        (self.safariSession as! ASWebAuthenticationSession).cancel()
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return (UIApplication.shared.delegate?.window ?? ASPresentationAnchor()) ?? ASPresentationAnchor()
    }
    
}
