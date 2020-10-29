//
//  LoginViewController.swift
//  FRAMEWORK
//
//  Created by Rhytthm Mahajan on 28/10/20.
//

import UIKit
import WebKit

public class LoginViewController: UIViewController {

    
    var webView: WKWebView!
    var Identifiers = ""
    var Key = ""
    var Secret = ""
    
    private func setupWebView() {
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "payloadCallback")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webView = WKWebView(frame: self.view.bounds, configuration: config)
    }
    
    @objc func productKey(_ notification: Notification){

            if let data = notification.userInfo as? [String: String]
               {
                    for (key, password) in data
                    {
                        Key = password
                        print("\(key) : \(password) ")
                    }
            }

    }
            
    @objc func identifierType(_ notification: Notification){

            if let data = notification.userInfo as? [String: String]
                {
                    for (identifier, Type) in data
                    {
                        Identifiers = Type
                        print("\(identifier) : \(Type) ")
                    }
            }
                
    }
    
    @objc func SecretKey(_ notification: Notification){

            if let data = notification.userInfo as? [String: String]
               {
                    for (SecretKey, password) in data
                    {
                        Secret = password
                        print("\(SecretKey) : \(password) ")
                    }
            }

    }


    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(productKey(_:)), name: Notification.Name("ProductKey"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(identifierType(_:)), name: Notification.Name("IdentifierType"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SecretKey(_:)), name: Notification.Name("SecretType"), object: nil)
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupWebView()
        self.view.addSubview(self.webView)
        let Url = "https://websdk.sawolabs.com/?apiKey=\(Key)&identifierType=\(Identifiers)&webSDKVariant=ios&apiKeySecret=\(Secret)"
        print(Url)

        if let url = URL(string: Url) {
        let request = URLRequest(url: url)
        self.webView.load(request)
        }
        print(Key)
        print(Identifiers)
        
    }
    
        


}
extension LoginViewController: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "payloadCallback" {
            print("JavaScript is sending a message \(message.body)")
            let s = String(describing: message.body)
            if s != "" {
            NotificationCenter.default.post(name: Notification.Name("LoginApproved"), object: nil)
            let Payload = ["UserPayload": s]
            NotificationCenter.default.post(name: Notification.Name("PayloadOfUser"), object: nil,userInfo: Payload)
        
            }
        }
    }
}
