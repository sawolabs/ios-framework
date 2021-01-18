# ios-framework
iOS framework to integrate the sawo-sdk in iOS applications
## Steps to integrate Sawo iOS Framework 
1. Login to sawo dev console - [dev.sawolabs.com](http://dev.sawolabs.com) 
   
2. Create a new project and copy the API key and Secret key.

3. Click Clone or download button in the <> Code tab and select Download ZIP to download the framework.

4. Create a new Xcode Project with a View Controller and create a login button and its action in the ViewController.swift file.

5. Import the the Sawo framework into your project by simply dragging and dropping 💼apiSawoFrame.framework file into your project and import the framework in your ViewController.swift file.

6. Add a cocoapod named swift keychain wrapper to your project.For that open your project folder in terminal and type in 'pod init', then open the pod file of your project and add the following line to the pod file and save it.
pod 'SwiftKeychainWrapper' 
Now go back to the terminal and type pod install to install the pod to your project. Once the pod has been installed xcworkspace file of your project and work on it.

7. Import the Framework and pod by adding following code.
```
import UIKit
import FrameworkV1
import SwiftKeychainWrapper

```

6. Add the following snippet above viewDidLoad func 
```
let VC = FrameworkV1.LoginViewController()
var PayloadApi = ""

var publicKeyApp = ""
var privateKeyApp = ""
var sessionIdApp = ""
    
var keychainPublicKEY = KeychainWrapper.standard.string(forKey: "publicKEY")
var keychainPrivateKEY = KeychainWrapper.standard.string(forKey: "privateKEY")
var keychainSessionID = KeychainWrapper.standard.string(forKey: "sessionID")

```

7. Add the following code snippet in your @IBAction func of the button
```
present(VC, animated: true, completion: nil)
let apiKey = ["apikey": "ab59f803-14c3-4cef-ade1-b31ec0fbef8d"]
let identifierType = ["identifier": "email"]
let secretKey = ["secretkey": "5f7cd216c501b54c7fe292d1vUmOUotM96qhrOCo06OfTZiz"]
let keychainPuK = ["keychainPuk": "\(String( keychainPublicKEY ?? "not found any"))"]
let keychainPrK = ["keychainPrk": "\(String( keychainPrivateKEY ?? "not found any"))"]
let keychainSess = ["keychainSess": "\(String( keychainSessionID ?? "not found any"))"]

print("on Login Pressed The values ....")
print(keychainPublicKEY)
print(keychainPrivateKEY)
print(keychainSessionID )

NotificationCenter.default.post(name: Notification.Name("ProductKey"), object: nil,userInfo: apiKey)
NotificationCenter.default.post(name: Notification.Name("IdentifierType"), object:nil, userInfo: identifierType)
NotificationCenter.default.post(name: Notification.Name("SecretType"), object:nil, userInfo: secretKey)
NotificationCenter.default.post(name: Notification.Name("keychainPuKFramework"), object: nil,userInfo: keychainPuK)
NotificationCenter.default.post(name: Notification.Name("ProductKeyFramework"), object: nil,userInfo: keychainPrK)
NotificationCenter.default.post(name: Notification.Name("keychainSessFramework"), object: nil,userInfo: keychainSess)

```
8. The following code in viewDidLoad func 
```
NotificationCenter.default.addObserver(self, selector: #selector(LoginIsApproved(_:)), name: Notification.Name("LoginApproved"), object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(loginCONTENTapi(_:)), name: Notification.Name("PayloadOfUser"), object: nil)

NotificationCenter.default.addObserver(self, selector: #selector(PublicKEYApp(_:)), name: Notification.Name("publickey"), object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(PrivateKEYApp(_:)), name: Notification.Name("privatekey"), object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(SessionIDApp(_:)), name: Notification.Name("sessionId"), object: nil)

```
9. Add a new View Controller to which you want to take your user after login. Create a Segue to this  View Controller and select its type as present modally. Inside Attributes inspector in presentation select full screen and give the segue a name in identifier.

10. Add the snippet below  viewDidLoad func
```

@objc func LoginIsApproved(_ notification: Notification){
    print("Login was Successful")
    self.dismiss(animated: true, completion: nil)
    performSegue(withIdentifier: "Sawo", sender: nil)
    

}


@objc func loginCONTENTapi(_ notification: Notification){
    if let data = notification.userInfo as? [String: String]
        {
            for (UserPayload, Content) in data
            {
                PayloadApi = Content
                print("\(UserPayload) : \(Content) ")
            }
    }

}

@objc func PublicKEYApp(_ notification: Notification){
    if let data = notification.userInfo as? [String: String]
        {
            for (PublicKEYApps, valuePublic) in data
            {
                publicKeyApp = valuePublic
                print("\(PublicKEYApps) : \(valuePublic) ")
                KeychainWrapper.standard.set(valuePublic, forKey: "publicKEY")
            }
    }
}

@objc func PrivateKEYApp(_ notification: Notification){
    if let data = notification.userInfo as? [String: String]
        {
            for (PrivateKEYApps, valuePrivate) in data
            {
                privateKeyApp = valuePrivate
                print("\(PrivateKEYApps) : \(valuePrivate) ")
                KeychainWrapper.standard.set(valuePrivate, forKey: "privateKEY")
            }
    }
}

@objc func SessionIDApp(_ notification: Notification){
    if let data = notification.userInfo as? [String: String]
        {
            for (SessionIDApps, valueSessionID) in data
            {
                sessionIdApp = valueSessionID
                print("\(SessionIDApps) : \(valueSessionID) ")
                KeychainWrapper.standard.set(valueSessionID, forKey: "sessionID")
            }
        
    }
    

}

}


```
11. Add values to the places marked in comments.

12. PayloadApi variable contains the user's payload.



   



