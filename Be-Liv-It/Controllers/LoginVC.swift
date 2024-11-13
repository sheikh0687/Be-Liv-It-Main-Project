//
//  LoginVC.swift
//  Be-Liv-It
//
//  Created by mac on 10/01/23.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

class LoginVC: UIViewController {
    
    @IBOutlet var textEmail: UITextField!
    @IBOutlet var textPassword: UITextField!
    
    var iconClick = false
    let imageIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "Status") == true {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DepartmentListVC") as! DepartmentListVC
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        imageIcon.image = UIImage(named: "openEye")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "openEye")!.size.width, height: UIImage(named: "openEye")!.size.height)
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "openEye")!.size.width, height: UIImage(named: "openEye")!.size.height)
        textPassword.rightView = contentView
        textPassword.rightViewMode = .always
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tapppedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick {
            iconClick = false
            tapppedImage.image = UIImage(named: "closeEye")
            textPassword.isSecureTextEntry = false
        }
        else {
            iconClick = true
            tapppedImage.image = UIImage(named: "openEye")
            textPassword.isSecureTextEntry = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func LoginApi() {
        let urlString = "https://techimmense.in/BE-LIV-IT-CLOUD/webservice/user_login?"
        let paramLogin = [
            "email": self.textEmail.text,
            "password": self.textPassword.text
        ]
        
        AF.request(urlString, parameters: paramLogin).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(UserLoginApi.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1" {
                        let userId = root.result?.id ?? ""
                        let userName = root.result?.user_name ?? ""
                        
                        UserDefaults.standard.set(userId, forKey: "id")
                        UserDefaults.standard.set(userName, forKey: "user_name")
                        UserDefaults.standard.set(true, forKey: "Status")
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DepartmentListVC") as! DepartmentListVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        self.openAlert(title: "Be-Liv_It", message: root.message ?? "", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                            print("Clicked Okay")
                            self.textEmail.text = ""
                            self.textPassword.text = ""
                            self.textEmail.becomeFirstResponder()
                        }])
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if let email = textEmail.text, let password = textPassword.text {
            UserDefaults.standard.set(self.textEmail.text!, forKey: "email")
            if email == "" {
                openAlert(title: "Alert", message: "Email address not found", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Clicked Okay")
                }])
                
            }else if password == ""{
                    openAlert(title: "Alert", message: "Password not found", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Clicked Okay")
                    }])} else {
                        self.LoginApi()
                    }
        }
    }
}
