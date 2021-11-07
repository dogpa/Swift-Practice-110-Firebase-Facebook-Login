//
//  LoginSuccessViewController.swift
//  Swift Practice # 110 Firebase Facebook Login
//
//  Created by Dogpa's MBAir M1 on 2021/11/7.
//

import UIKit
import Firebase
import FacebookLogin

class LoginSuccessViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //先登出Firebase後登出FB 登出後跳回第一頁
    @IBAction func tryToLoginOut(_ sender: UIButton) {
        
        do{
            try Auth.auth().signOut()
            let manager = LoginManager()
            manager.logOut()
        }catch{
            print(error.localizedDescription)
        }
        self.transferViewController(0)
        
    }
    
    

}
