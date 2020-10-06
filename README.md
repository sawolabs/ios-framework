# ios-framework
iOS framework to integrate the sawo-sdk in iOS applications
## Steps to integrate Sawo iOS Framework 

1. Login to sawo dev console - [dev.sawolabs.com](http://dev.sawolabs.com)

2. Create a new project and copy the API key

3. Create a new Xcode Project with a View Controller and create a login button and its action in the ViewController.swift file.

4. Import the the Sawo framework into your project by simply dragging and dropping 💼apiSawoFrame.framework file into your project and import the framework in your ViewController.swift file.

5. Add the following snippet above viewDidLoad func 
```
let VC = apiSawoFrame.LoginViewController()
var PayloadApi = ""

```

6. Add the following code snippet in your @IBAction func of the button
```
present(VC, animated: true, completion: nil)
let apiKey = ["apikey": "<ADD-YOUR-KEY-HERE>"]   \\ ADD YOUR API-KEY HERE
let identifierType = ["identifier": "<ADD-IDENTIFIER-HERE>"]   \\ ADD IDENTIFIER HERE
NotificationCenter.default.post(name: Notification.Name("ProductKey"), object: nil,userInfo: apiKey)
NotificationCenter.default.post(name: Notification.Name("IdentifierType"), object:nil, userInfo: identifierType)

```
7. The following code in viewDidLoad func 
```
NotificationCenter.default.addObserver(self, selector: #selector(LoginIsApproved(_:)), name: Notification.Name("LoginApproved"), object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(loginCONTENTapi(_:)), name: Notification.Name("PayloadOfUser"), object: nil)

```
8. Add a new View Controller to which you want to take your user after login. Create a Segue to this  View Controller and select its type as present modally. Inside Attributes           inspector in presentation select full screen and give the segue a name in identifier.

9. Add the snippet below  viewDidLoad func
```
@objc func LoginIsApproved(_ notification: Notification){
    print("Login was Successful")
    self.dismiss(animated: true, completion: nil)
    performSegue(withIdentifier: "<ADD-SEGUE-IDENTIFIER-HERE>", sender: nil)  \\ ADD SEGUE NAME HERE
    

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
```
10. Add values to the places marked in comments.

11. PayloadApi variable contains the user's payload.



   



