//
//  RegisterPAgeViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/8/21.
//

import UIKit
import FirebaseAuth


class RegisterPAgeViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Register"
        
    
  
    }
    @IBAction func RegisterClicked(_ sender: Any) {
        print("Register \(userNameTextField.text!) \(passwordTextField.text!)")
        if (userNameTextField.text == "" || passwordTextField.text == ""){
            UserDefaults.standard.setValue("RegisterPAgeViewController", forKey: "controllerCalledPopup")
            showEmptyInfoPopUP()
            return
            
        }
        createUser(email: userNameTextField.text!, password: passwordTextField.text!)
            
        
        
    }
    func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let _ = authResult?.user,error == nil else {
                if(error?.localizedDescription == "The email address is already in use by another account."){
                    self.showEmailsExistsPopUP()
                }
                print(error!.localizedDescription)
                return
            }
            self.registerSuccessPopup()
        
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
    func showEmailsExistsPopUP(){
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "EmailpopUpViewController")as! EmailpopUpViewController
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
    
    }

    func registerSuccessPopup(){
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "RegisterSuccessPopupViewController")as! RegisterSuccessPopupViewController
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)        
    }
    
    
}
