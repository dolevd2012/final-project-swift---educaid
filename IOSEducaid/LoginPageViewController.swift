//
//  LoginPageViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/8/21.
//

import UIKit
import FirebaseAuth

class LoginPageViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.cyan
        navigationController?.navigationBar.topItem?.title = "Login"
    
    }
    
    //MARK: Login button Pressed Logic
    @IBAction func LoginButtonClicked(_ sender: Any) {
        if (userNameTextField.text == "" || passwordTextField.text == ""){
            UserDefaults.standard.setValue("LoginPageViewController", forKey: "controllerCalledPopup")
            showEmptyInfoPopUP()
        }
        Auth.auth().signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!) { AuthDataResult, error in
            if(error != nil){
                self.showWrongLoginInfoPopUP()
                return
            }
            print("Login successful")
            self.TransferUserTotheTabView()
        }
    }
    
    
    
    //MARK: open popUp when user didnt fill username or password
    func showEmptyInfoPopUP(){
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "popUpViewController")as! popUpViewController
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        
    }
    //MARK: open popUp when user didnt fill username or password
    func showWrongLoginInfoPopUP(){
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "WrongLoginInfopopUpViewController")as! WrongLoginInfopopUpViewController
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        
    }
    
    //MARK: open tab view when user Loged in succesfully
    func TransferUserTotheTabView(){
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "UITabBarController")
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
    }
    
}
