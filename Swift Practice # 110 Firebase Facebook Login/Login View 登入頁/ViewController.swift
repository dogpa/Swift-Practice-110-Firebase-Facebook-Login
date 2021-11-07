//
//  ViewController.swift
//  Swift Practice # 110 Firebase Facebook Login
//
//  Created by Dogpa's MBAir M1 on 2021/11/7.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Firebase


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //viewDidAppear來偵測，已經登入了就跳到第2頁
    //沒有登入的話顯示FBLoginButton ， 但這顆Button目前只能登入FB 還無法登入Firebase
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = AccessToken.current, !token.isExpired {
            self.transferViewController(1)
        }else{
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            
            loginButton.permissions = ["public_profile"]
            view.addSubview(loginButton)
        }
        
    }
    
    
    //登入FB後登入Firebase的Button
    //透過LoginManager的manager.logIn協助登入
    //登入成功後透過取得的資料向Firebase發登入請求
    @IBAction func buttonToLoginFB(_ sender: UIButton) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
            if case LoginResult.success(granted: _, declined: _, token: let token) = result {
                print("fb login ok")
                
                let credential =  FacebookAuthProvider.credential(withAccessToken: token!.tokenString)
                    Auth.auth().signIn(with: credential) { [weak self] (result, error) in
                    guard let self = self else { return }
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    print("login ok")
                        self.transferViewController(1)
                }
            } else {
                print("login fail")
            }
        }
    }
    
    
    // Swift override func viewDidLoad() { super.viewDidLoad() if let token = AccessToken.current, !token.isExpired { // User is logged in, do work such as go to next view controller. } }
        
    
    // Swift // // Extend the code sample from 6a.Add Facebook Login to Your Code // Add to your viewDidLoad method: loginButton.permissions = ["public_profile", "email"]


}






