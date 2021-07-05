//
//  RegisterSuccessPopupViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/12/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class RegisterSuccessPopupViewController: UIViewController {

    @IBOutlet weak var nameTextArea: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func submitButtonClicked(_ sender: Any) {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        
        var dict = [String:Any]()
        dict.updateValue(nameTextArea.text!, forKey: "name")
        dict.updateValue(0, forKey: "riddlesSolved")
        dict.updateValue(0, forKey: "score")
        var riddlesQ = [String:Any]()
        riddlesQ.updateValue("", forKey: "0")
        dict.updateValue(riddlesQ, forKey: "riddlesQuestion")
        var riddlesA = [String:Any]()
        riddlesA.updateValue("", forKey: "0")
        dict.updateValue(riddlesA, forKey: "riddlesAnswer")
        
        
        ref.child("users").child(userID!).setValue(dict)
        
        
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "UITabBarController")
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
    }
}
